Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A8E20BADA
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Jun 2020 23:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgFZVCD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Jun 2020 17:02:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45423 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgFZVCC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 26 Jun 2020 17:02:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id g17so4682029plq.12;
        Fri, 26 Jun 2020 14:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fu/Z3h59Qi11bfBtgTVUekaF3cv+TaA41WG230vnSZM=;
        b=cPgyXwz4Lc5QnKe8kKUyKHQVylOl8PPRNCgupmuItsPlhw+gFvP7t/iyJ3eOl1JwIL
         s4nfD/sBxtyvatCDGK8JTb+xKPZoFxqW5RXU1xLRMqJeKwBpz9r5hoJL2HweDY3YNb+U
         YTnTde4/u8LSox+VRRdHgwLeOi9axRD4hZ/H/wGjwGMkNWybJTea6Ea8vUqF0Q9xeq5P
         woV64QGwziL7WaIzFUL+FdC+2QNnjteHA2XJXMLep3Ag0gL3bVWH3zIyt8PqQktDivC8
         wlvFKXIXCnuPEWUyTkV2wKRf73mS/0rx6jsqmWgfwSu/PQY+uKeLN+jqg8G4TvPgFXi+
         Q3cw==
X-Gm-Message-State: AOAM532SvzP8iG214yl8cNzYtQ6L4XAwZcwh/R1sJQCiRahKlqfGb+o1
        TVcDFAQ2QIunzcd6rj2/GoA=
X-Google-Smtp-Source: ABdhPJzcFUMrDK3UVS4LX1RK8H1O402fwEur56/ry3N6LwS/XKqtOSsHTKCSV0iIMplRjOlZMiqIxA==
X-Received: by 2002:a17:90a:e2c7:: with SMTP id fr7mr1713020pjb.103.1593205321604;
        Fri, 26 Jun 2020 14:02:01 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id w15sm12325067pjb.44.2020.06.26.14.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:02:01 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:02:00 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: fpga: xilinx-slave-serial: add
 optional INIT_B GPIO
Message-ID: <20200626210200.GA2259@epycbox.lan>
References: <20200622133723.23326-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622133723.23326-1-luca@lucaceresoli.net>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 22, 2020 at 03:37:22PM +0200, Luca Ceresoli wrote:
> The INIT_B is used by the 6 and 7 series to report the programming status,
> providing more control and information about programming errors.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes in v2:
>  - rename init_b-gpios to init-b-gpios (Rob Herring suggested to not use '_'
>    in property names)
> ---
>  .../devicetree/bindings/fpga/xilinx-slave-serial.txt       | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> index 9f103f3872e8..5ef659c1394d 100644
> --- a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> +++ b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> @@ -16,6 +16,10 @@ Required properties:
>  - prog_b-gpios: config pin (referred to as PROGRAM_B in the manual)
>  - done-gpios: config status pin (referred to as DONE in the manual)
>  
> +Optional properties:
> +- init-b-gpios: initialization status and configuration error pin
> +                (referred to as INIT_B in the manual)
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
> +			init-b-gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
> +			done-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
>  		};
>  	};
> -- 
> 2.27.0
> 

Will apply to for-next,

Thanks!
