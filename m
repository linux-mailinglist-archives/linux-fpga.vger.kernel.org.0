Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBCF1FA7DC
	for <lists+linux-fpga@lfdr.de>; Tue, 16 Jun 2020 06:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgFPEmG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 Jun 2020 00:42:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33442 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgFPEmG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 16 Jun 2020 00:42:06 -0400
Received: by mail-io1-f67.google.com with SMTP id i25so160026iog.0;
        Mon, 15 Jun 2020 21:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+a0gGFXhmNQdUthZidZAy1jsxYqlreoERJ4tMXAeBPk=;
        b=SGPqunUdewTilyUAX0MAJK7YIp2ObvbjiCtK33nnEaSsZYkxX8yIGKGG/FF2hnPHty
         VdSAxUjFPmrBd6CgUoi53qcq3dg4qc6WKeFBPZRLHof73hoIP1CTM1ASeSxhgKNh1tIu
         g9HMCKuei9s/hdaWN0o/FKqVxNbJTNULGQ5xOk+SlNlWRLUQR1ILrA+EEjnA2CEhM3+U
         s2WnkY9PGOHlWniSUZtfTCAoTsWc0mQSeozHT+tWtGDk9J0E8VHrVe5dPZkr7bOQeNF0
         iTcxgc1FaK76fmHfpngJq70QB3FuxTfDbAE8nSmJIkXG9emaviR5VFLfL0XU7CRx5lZH
         c0XQ==
X-Gm-Message-State: AOAM533gF7pzzk3kVSp5+u98ykN9xxEtnk5ot7gUyKIIPtLLE9RWPMU0
        Pzr3vV69pkWvbAY0o5yQ1PuSLiX3NTY=
X-Google-Smtp-Source: ABdhPJyUMw0oE51vIBMiFJW+SJ9w5Y2lXDWdOze+gRJ9zLufs7gomgFA2C1NCTaH9KdaFDoU/cGfCw==
X-Received: by 2002:a6b:7b4a:: with SMTP id m10mr865233iop.55.1592282524888;
        Mon, 15 Jun 2020 21:42:04 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id e25sm9137916ios.0.2020.06.15.21.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 21:42:03 -0700 (PDT)
Date:   Mon, 15 Jun 2020 21:42:02 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/5] dt-bindings: fpga: xilinx-slave-serial: valid for
 the 7 Series too
Message-ID: <20200616044202.GA46300@epycbox.lan>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611211144.9421-1-luca@lucaceresoli.net>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jun 11, 2020 at 11:11:40PM +0200, Luca Ceresoli wrote:
> The Xilinx 7-series uses the same protocol, mention that.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  .../devicetree/bindings/fpga/xilinx-slave-serial.txt     | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> index cfa4ed42b62f..9f103f3872e8 100644
> --- a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> +++ b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> @@ -1,11 +1,14 @@
>  Xilinx Slave Serial SPI FPGA Manager
>  
> -Xilinx Spartan-6 FPGAs support a method of loading the bitstream over
> -what is referred to as "slave serial" interface.
> +Xilinx Spartan-6 and 7 Series FPGAs support a method of loading the
> +bitstream over what is referred to as "slave serial" interface.
>  The slave serial link is not technically SPI, and might require extra
>  circuits in order to play nicely with other SPI slaves on the same bus.
>  
> -See https://www.xilinx.com/support/documentation/user_guides/ug380.pdf
> +See:
> +- https://www.xilinx.com/support/documentation/user_guides/ug380.pdf
> +- https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
> +- https://www.xilinx.com/support/documentation/application_notes/xapp583-fpga-configuration.pdf
>  
>  Required properties:
>  - compatible: should contain "xlnx,fpga-slave-serial"
> -- 
> 2.27.0
> 
