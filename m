Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B76331851
	for <lists+linux-fpga@lfdr.de>; Mon,  8 Mar 2021 21:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCHUUM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 8 Mar 2021 15:20:12 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:45923 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhCHUTs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 8 Mar 2021 15:19:48 -0500
Received: by mail-io1-f43.google.com with SMTP id a7so11347980iok.12;
        Mon, 08 Mar 2021 12:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NcG6ZqO4p6QZgXbPCgWzjprzED+TuNKHh2ID9qjkO6M=;
        b=OvIL3qEgxQkY3ssNAIbuxwEH+rvOStk9zugf1TjHF2in0Tu+HSZhtLXZIjdyeoMxft
         snyxmUuJ1fWEE1U6GXAUImHlocTAAiR7lh6z8KQCRJNdwG1sjEXpLYWVfBsYl77mvGf9
         fynPykHiCqEXfuW1xpFSCMVRRM++zTSbRhpk8OUS+ro/pQ3XL6MSBGUyBMeupcOMAywI
         4FwwXteHpCYsXHHeKjyKZzljrsQmREYwppInj5uOGxKdERhExpNttZB3A3IYo3T4Nv2E
         0MMreDqLVMa+uZ9rY3U+ve4l6xwCmh/a01rmOfkw5Q9BIPz2OGsQeyPHa+Rmzzu+cdTq
         o8Vw==
X-Gm-Message-State: AOAM5337sSwIXBHFlpA9Ga6m+LQv2fdwEyKqS/VMyQeSphb9wGb4ulkp
        4PrutO1XVzTlX+rElXvtvA==
X-Google-Smtp-Source: ABdhPJy/ZGuyoAd9MktEIjw1VXRRagJzg7rGusa9KJa5EvGqsBJyUHx7q4jtGsbflpahG8+vLwaFjA==
X-Received: by 2002:a05:6602:82:: with SMTP id h2mr20489812iob.20.1615234787570;
        Mon, 08 Mar 2021 12:19:47 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a14sm6394626ilj.39.2021.03.08.12.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:19:46 -0800 (PST)
Received: (nullmailer pid 2894804 invoked by uid 1000);
        Mon, 08 Mar 2021 20:19:44 -0000
Date:   Mon, 8 Mar 2021 13:19:44 -0700
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, trix@redhat.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, jolly.shah@xilinx.com,
        rajan.vaja@xilinx.com, arnd@arndb.de, manish.narani@xilinx.com,
        amit.sunil.dhamne@xilinx.com, tejas.patel@xilinx.com,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chinnikishore369@gmail.com,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: fpga: Add binding doc for versal
 fpga manager
Message-ID: <20210308201944.GA2886704@robh.at.kernel.org>
References: <20210304070224.22346-1-nava.manne@xilinx.com>
 <20210304070224.22346-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304070224.22346-3-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Mar 04, 2021 at 12:32:23PM +0530, Nava kishore Manne wrote:
> From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> 
> This patch adds binding doc for versal fpga manager driver.

Why do you need a DT entry for this? Can't the Versal firmware driver 
instantiate the fpga-mgr device?

> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
> Changes for v2:
>                 -Fixed file format and syntax issues.
> Changes for v3:
>                 -Removed unwated extra spaces.
> 
>  .../bindings/fpga/xlnx,versal-fpga.yaml       | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
> new file mode 100644
> index 000000000000..fec6144766fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/xlnx,versal-fpga.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Versal FPGA driver.
> +
> +maintainers:
> +  - Nava kishore Manne <nava.manne@xilinx.com>
> +
> +description: |
> +  Device Tree Versal FPGA bindings for the Versal SoC, controlled
> +  using firmware interface.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - xlnx,versal-fpga
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    versal_fpga: fpga {
> +         compatible = "xlnx,versal-fpga";
> +    };
> +
> +...
> -- 
> 2.18.0
> 
