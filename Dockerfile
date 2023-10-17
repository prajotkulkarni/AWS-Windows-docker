FROM 481331750683.dkr.ecr.us-east-1.amazonaws.com/baseimg:dotnetfw4.8 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY AWSECSSample/*.csproj ./AWSECSSample/
COPY AWSECSSample/*.config ./AWSECSSample/
RUN nuget restore

# copy everything else and build app
COPY AWSECSSample/. ./AWSECSSample/
WORKDIR /app/AWSECSSample
RUN msbuild /p:Configuration=Release

# copy build artifacts into runtime image
FROM 481331750683.dkr.ecr.us-east-1.amazonaws.com/baseimg:aspnet4.8 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build /app/AWSECSSample/. ./