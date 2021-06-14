Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788F13A6987
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhFNPFr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 11:05:47 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:44916 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhFNPFr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Jun 2021 11:05:47 -0400
Received: by mail-il1-f180.google.com with SMTP id i17so12450373ilj.11;
        Mon, 14 Jun 2021 08:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ORcJk31TiVnuEogk3RJcUiauMJCVCh/REeNy+uWJyuI=;
        b=Q30pWdmsyox1BEsn8LU2WQR4fhKxEL5SZFm96nZM/hXxLPhBPLKzs31+ZD4e17Druv
         3AfPTyY9LflPD0Ux3ID8wyzan9wRioikfdlMO263W/KgMzANMkDj4hCILT86v46BLd7Q
         PFmSixOx8Yu5iID9nM1LqS20cbC0d+aIbKpkvl5wX5Nz3ab0CKXhgF603EYJBhNAMBIW
         S68PYwT9qA59oaW/xgdvvse6DCzliRIaDfD+mxmtXReXBgPyD9DaLXf9lCguiQPFPsGs
         7lKWxzwLNC8MDlMnaBwJo+FD4bXzkEUrolV12VFGEjwKbgjz630hAB6FUZZBEalB5emT
         Pyaw==
X-Gm-Message-State: AOAM5319XGqf/GWu7QFPZoQN32WlX1i/W56aXzNoTvO9ghR2EFgahK96
        Km9qvob7m8xCoHf1H0L7F51wBjTMjg==
X-Google-Smtp-Source: ABdhPJxevxIhIoghxuFi1Czoup2tc4Tf11I/KvnTMIECwiSsVK/e/doraZRmwywMjpT9+SnmMWGoQw==
X-Received: by 2002:a92:190f:: with SMTP id 15mr13571076ilz.45.1623683023926;
        Mon, 14 Jun 2021 08:03:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i13sm7633657ilr.16.2021.06.14.08.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:03:42 -0700 (PDT)
Received: (nullmailer pid 758861 invoked by uid 1000);
        Mon, 14 Jun 2021 15:03:41 -0000
Date:   Mon, 14 Jun 2021 09:03:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, shubhrajyoti.datta@xilinx.com,
        navam@xilinx.com, peter.crosthwaite@xilinx.com,
        soren.brinkmann@xilinx.com
Subject: Re: [PATCH] dt-bindings: serial: convert Cadence UART bindings to
 YAML
Message-ID: <20210614150341.GA747048@robh.at.kernel.org>
References: <20210613213359.296400-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210613213359.296400-1-iwamatsu@nigauri.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 14, 2021 at 06:33:59AM +0900, Nobuhiro Iwamatsu wrote:
> Convert serial for Cadence UART bindings documentation to YAML.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  .../devicetree/bindings/serial/cdns,uart.txt  | 27 --------
>  .../devicetree/bindings/serial/cdns,uart.yaml | 68 +++++++++++++++++++
>  2 files changed, 68 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt b/Documentation/devicetree/bindings/serial/cdns,uart.txt
> deleted file mode 100644
> index 4efc560f90abbd..00000000000000
> --- a/Documentation/devicetree/bindings/serial/cdns,uart.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -Binding for Cadence UART Controller
> -
> -Required properties:
> -- compatible :
> -  Use "xlnx,xuartps","cdns,uart-r1p8" for Zynq-7xxx SoC.
> -  Use "xlnx,zynqmp-uart","cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC.
> -- reg: Should contain UART controller registers location and length.
> -- interrupts: Should contain UART controller interrupts.
> -- clocks: Must contain phandles to the UART clocks
> -  See ../clocks/clock-bindings.txt for details.
> -- clock-names: Tuple to identify input clocks, must contain "uart_clk" and "pclk"
> -  See ../clocks/clock-bindings.txt for details.
> -
> -
> -Optional properties:
> -- cts-override : Override the CTS modem status signal. This signal will
> -  always be reported as active instead of being obtained from the modem status
> -  register. Define this if your serial port does not use this pin
> -
> -Example:
> -	uart@e0000000 {
> -		compatible = "cdns,uart-r1p8";
> -		clocks = <&clkc 23>, <&clkc 40>;
> -		clock-names = "uart_clk", "pclk";
> -		reg = <0xE0000000 0x1000>;
> -		interrupts = <0 27 4>;
> -	};
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> new file mode 100644
> index 00000000000000..ce467fa464bfd0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/cdns,uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence UART Controller Device Tree Bindings
> +
> +maintainers:
> +  - Michal Simek <michal.simek@xilinx.com>
> +
> +allOf:
> +  - $ref: /schemas/serial.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: UART controller for Zynq-7xxx SoC
> +        items:
> +          - enum:
> +            - xlnx,xuartps
> +            - cdns,uart-r1p8

What you want is:

items:
  - const: xlnx,xuartps
  - const: cdns,uart-r1p8

> +      - description: UART controller for Zynq Ultrascale+ MPSoC
> +        items:
> +          - enum:
> +            - xlnx,zynqmp-uart
> +            - cdns,uart-r1p12
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: uart_clk
> +      - const: pclk
> +
> +  cts-override:
> +    description: |
> +      Override the CTS modem status signal. This signal will
> +      always be reported as active instead of being obtained
> +      from the modem status register. Define this if your serial
> +      port does not use this pin.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false

unevaluatedProperties: false

because you could have child nodes with attached devices.

> +
> +examples:
> +  - |
> +    serial@e0000000 {
> +      compatible = "cdns,uart-r1p8";

This is wrong based on what the binding said.

> +      clocks = <&clkc 23>, <&clkc 40>;
> +      clock-names = "uart_clk", "pclk";
> +      reg = <0xE0000000 0x1000>;
> +      interrupts = <0 27 4>;
> +    };
> -- 
> 2.32.0
