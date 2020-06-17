Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C581FD909
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Jun 2020 00:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFQWj6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 Jun 2020 18:39:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41710 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQWj5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 17 Jun 2020 18:39:57 -0400
Received: by mail-io1-f67.google.com with SMTP id o5so4835537iow.8;
        Wed, 17 Jun 2020 15:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/0XRrWZ/TEBr4RUvpfLqtHCp+br8TfRsV/u8yEznsc=;
        b=QK3pAly4D1iUbIiRmuMtKWQAnQZfEIsBaLxITX2kCpGQsc65UD5LubI3KSMnSfFKrW
         Dh1Wsv35+lzGtZ87HqgBKPv3G1nPCPcm2Ny3HXCHN/om8PcvK+asFMQnpuyC51hJdnXh
         lfOkhc03X/TpLkX8gzXGY1R07u1aNg78gfbo3Klvh7xTu5NqTRtHgHRxYBbZ1Kl+fwPl
         vv+PfIk7MMXanu7XTLqRP3FivvaX2LnY3yK1LIq4cKh974PNu/CKdmvZfodnRi8me4P3
         5JwPAeBHtbjvaYxHLDDs8FgpAd1I6zpKhFKAzcR+76aB9br9d5hMm05mvB73mQ9dvpht
         DqSw==
X-Gm-Message-State: AOAM532rqkSybeWPvAVqpwGMuR7Vf0ZlcgwQ6S2UuDrhjnw4BqUX5KhE
        A2gZu03tZpHFXi0rMptTeg==
X-Google-Smtp-Source: ABdhPJzDXYDIpACDxBvujy5MufeVT3XLKfM2y8iU9whiQUjkAGUKbIu5oYvycaqq2ZysLIV9y9O44w==
X-Received: by 2002:a05:6602:15c8:: with SMTP id f8mr1793105iow.183.1592433596862;
        Wed, 17 Jun 2020 15:39:56 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q5sm535000ile.37.2020.06.17.15.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:39:56 -0700 (PDT)
Received: (nullmailer pid 2969158 invoked by uid 1000);
        Wed, 17 Jun 2020 22:39:55 -0000
Date:   Wed, 17 Jun 2020 16:39:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 4/5] dt-bindings: fpga: xilinx-slave-serial: add optional
 INIT_B GPIO
Message-ID: <20200617223955.GA2967317@bogus>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
 <20200611211144.9421-4-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611211144.9421-4-luca@lucaceresoli.net>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jun 11, 2020 at 11:11:43PM +0200, Luca Ceresoli wrote:
> The INIT_B is used by the 6 and 7 series to report the programming status,
> providing more control and information about programming errors.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  .../devicetree/bindings/fpga/xilinx-slave-serial.txt       | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> index 9f103f3872e8..a049082e1513 100644
> --- a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> +++ b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> @@ -16,6 +16,10 @@ Required properties:
>  - prog_b-gpios: config pin (referred to as PROGRAM_B in the manual)
>  - done-gpios: config status pin (referred to as DONE in the manual)
>  
> +Optional properties:
> +- init_b-gpios: initialization status and configuration error pin
> +                (referred to as INIT_B in the manual)

Don't use '_' in property names:

init-b-gpios

> +
>  Example for full FPGA configuration:
>  
>  	fpga-region0 {
> @@ -40,7 +44,8 @@ Example for full FPGA configuration:
>  			spi-max-frequency = <60000000>;
>  			spi-cpha;
>  			reg = <0>;
> -			done-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
>  			prog_b-gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
> +			init_b-gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
> +			done-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
>  		};
>  	};
> -- 
> 2.27.0
> 
