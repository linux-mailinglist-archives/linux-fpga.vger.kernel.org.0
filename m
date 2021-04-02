Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190CF352DF3
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Apr 2021 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhDBRAm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Apr 2021 13:00:42 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:33527 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBRAm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 2 Apr 2021 13:00:42 -0400
Received: by mail-pg1-f181.google.com with SMTP id y3so1136843pgi.0;
        Fri, 02 Apr 2021 10:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yfmbeCjzAcIY6Zql5/5pz42umgxPuwS2SmaIC2vc5pY=;
        b=FZPMUK5YDemYBPtDsa8VCeILV76M4ExnUGmluM11wNy8qXYcxR/F4XfXibpW1KAQQW
         CCjhXpFASTQPAXQ4yQZsKdWnkiFKLN7F8IfZvxQv3cCgoDXkpiCe5giaBUkk2xP7vgKs
         FeCF9+3THYYF0vAA9Ekn9ZdJkhA6h6wZDRZk44aeDwxOtnUCl+u6S+qGYmS32XdvBk8m
         nn8gclRt4k5mppF2JL9VQGhgDtEAow+oEKHC3aIMO5IqRPEmgRUXDwPPC4iEhq7pjYkL
         DVspDAOK5gEF3FNeCl9quMCYSdrtoWiMkpNKFyZp/IP2McJmsW/YsF83OWrndGpJSBrR
         IsBQ==
X-Gm-Message-State: AOAM530lRCd4r8YG5WrT624OzZvT8HDb09ZvwqfJLluIDMxddYVmRU0j
        JD9uYO9rVGm2qBgpMZ+dKmY=
X-Google-Smtp-Source: ABdhPJw+bwVndI4Geafg6Wsv6bgKKOUeb89QWB3fuPCsXAm2vUOv/jp6u24fbpsHGRF+jZ5uGnw9Og==
X-Received: by 2002:a65:4942:: with SMTP id q2mr12321266pgs.34.1617382840707;
        Fri, 02 Apr 2021 10:00:40 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id e190sm8581134pfe.3.2021.04.02.10.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:00:39 -0700 (PDT)
Date:   Fri, 2 Apr 2021 10:00:38 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fpga: fpga-region: Convert to sugar syntax
Message-ID: <YGdNtmUJwMjwgImx@epycbox.lan>
References: <e73c46db7f1474417cbc3c2d8f582d2e62833eeb.1617364549.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e73c46db7f1474417cbc3c2d8f582d2e62833eeb.1617364549.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Geert,

On Fri, Apr 02, 2021 at 01:57:49PM +0200, Geert Uytterhoeven wrote:
> Using overlay sugar syntax makes the DTS files easier to read (and
> write).
> 
> While at it, fix two build issues:
>   - "/dts-v1/" and "/plugin/" must be separate statements.
>   - Add a missing closing curly brace.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/fpga/fpga-region.txt  | 187 ++++++++----------
>  1 file changed, 85 insertions(+), 102 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> index e811cf8250199b14..d787d57491a1c537 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -245,36 +245,31 @@ Base tree contains:
>  
>  Overlay contains:
>  
> -/dts-v1/ /plugin/;
> -/ {
> -	fragment@0 {
> -		target = <&fpga_region0>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		__overlay__ {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			firmware-name = "soc_system.rbf";
> -			fpga-bridges = <&fpga_bridge1>;
> -			ranges = <0x20000 0xff200000 0x100000>,
> -				 <0x0 0xc0000000 0x20000000>;
> -
> -			gpio@10040 {
> -				compatible = "altr,pio-1.0";
> -				reg = <0x10040 0x20>;
> -				altr,ngpio = <4>;
> -				#gpio-cells = <2>;
> -				clocks = <2>;
> -				gpio-controller;
> -			};
> -
> -			onchip-memory {
> -				device_type = "memory";
> -				compatible = "altr,onchipmem-15.1";
> -				reg = <0x0 0x10000>;
> -			};
> -		};
> +/dts-v1/;
> +/plugin/;
> +
> +&fpga_region0 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	firmware-name = "soc_system.rbf";
> +	fpga-bridges = <&fpga_bridge1>;
> +	ranges = <0x20000 0xff200000 0x100000>,
> +		 <0x0 0xc0000000 0x20000000>;
> +
> +	gpio@10040 {
> +		compatible = "altr,pio-1.0";
> +		reg = <0x10040 0x20>;
> +		altr,ngpio = <4>;
> +		#gpio-cells = <2>;
> +		clocks = <2>;
> +		gpio-controller;
> +	};
> +
> +	onchip-memory {
> +		device_type = "memory";
> +		compatible = "altr,onchipmem-15.1";
> +		reg = <0x0 0x10000>;
>  	};
>  };
>  
> @@ -371,25 +366,22 @@ Live Device Tree contains:
>  	};
>  
>  DT Overlay contains:
> -/dts-v1/ /plugin/;
> -/ {
> -fragment@0 {
> -	target = <&fpga_region0>;
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&fpga_region0 {
>  	#address-cells = <1>;
>  	#size-cells = <1>;
> -	__overlay__ {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>  
> -		firmware-name = "zynq-gpio.bin";
> +	firmware-name = "zynq-gpio.bin";
>  
> -		gpio1: gpio@40000000 {
> -			compatible = "xlnx,xps-gpio-1.00.a";
> -			reg = <0x40000000 0x10000>;
> -			gpio-controller;
> -			#gpio-cells = <0x2>;
> -			xlnx,gpio-width= <0x6>;
> -		};
> +	gpio1: gpio@40000000 {
> +		compatible = "xlnx,xps-gpio-1.00.a";
> +		reg = <0x40000000 0x10000>;
> +		gpio-controller;
> +		#gpio-cells = <0x2>;
> +		xlnx,gpio-width= <0x6>;
>  	};
>  };
>  
> @@ -402,41 +394,37 @@ This example programs the FPGA to have two regions that can later be partially
>  configured.  Each region has its own bridge in the FPGA fabric.
>  
>  DT Overlay contains:
> -/dts-v1/ /plugin/;
> -/ {
> -	fragment@0 {
> -		target = <&fpga_region0>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		__overlay__ {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			firmware-name = "base.rbf";
> -
> -			fpga-bridge@4400 {
> -				compatible = "altr,freeze-bridge-controller";
> -				reg = <0x4400 0x10>;
> -
> -				fpga_region1: fpga-region1 {
> -					compatible = "fpga-region";
> -					#address-cells = <0x1>;
> -					#size-cells = <0x1>;
> -					ranges;
> -				};
> -			};
> -
> -			fpga-bridge@4420 {
> -				compatible = "altr,freeze-bridge-controller";
> -				reg = <0x4420 0x10>;
> -
> -				fpga_region2: fpga-region2 {
> -					compatible = "fpga-region";
> -					#address-cells = <0x1>;
> -					#size-cells = <0x1>;
> -					ranges;
> -				};
> -			};
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&fpga_region0 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	firmware-name = "base.rbf";
> +
> +	fpga-bridge@4400 {
> +		compatible = "altr,freeze-bridge-controller";
> +		reg = <0x4400 0x10>;
> +
> +		fpga_region1: fpga-region1 {
> +			compatible = "fpga-region";
> +			#address-cells = <0x1>;
> +			#size-cells = <0x1>;
> +			ranges;
> +		};
> +	};
> +
> +	fpga-bridge@4420 {
> +		compatible = "altr,freeze-bridge-controller";
> +		reg = <0x4420 0x10>;
> +
> +		fpga_region2: fpga-region2 {
> +			compatible = "fpga-region";
> +			#address-cells = <0x1>;
> +			#size-cells = <0x1>;
> +			ranges;
>  		};
>  	};
>  };
> @@ -451,28 +439,23 @@ differences are that the FPGA is partially reconfigured due to the
>  "partial-fpga-config" boolean and the only bridge that is controlled during
>  programming is the FPGA based bridge of fpga_region1.
>  
> -/dts-v1/ /plugin/;
> -/ {
> -	fragment@0 {
> -		target = <&fpga_region1>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		__overlay__ {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			firmware-name = "soc_image2.rbf";
> -			partial-fpga-config;
> -
> -			gpio@10040 {
> -				compatible = "altr,pio-1.0";
> -				reg = <0x10040 0x20>;
> -				clocks = <0x2>;
> -				altr,ngpio = <0x4>;
> -				#gpio-cells = <0x2>;
> -				gpio-controller;
> -			};
> -		};
> +/dts-v1/;
> +/plugin/;
> +
> +&fpga_region1 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	firmware-name = "soc_image2.rbf";
> +	partial-fpga-config;
> +
> +	gpio@10040 {
> +		compatible = "altr,pio-1.0";
> +		reg = <0x10040 0x20>;
> +		clocks = <0x2>;
> +		altr,ngpio = <0x4>;
> +		#gpio-cells = <0x2>;
> +		gpio-controller;
>  	};
>  };
>  
> -- 
> 2.25.1
> 

Applied to for-next,
Thanks
