Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54343462A10
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Nov 2021 02:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhK3CDP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Nov 2021 21:03:15 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38645 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhK3CDP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 Nov 2021 21:03:15 -0500
Received: by mail-ot1-f49.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso28175945ota.5;
        Mon, 29 Nov 2021 17:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eq2Z4p4zmg6qNiDpmQANYb40whj6Zi1W7Ros/gT3PVM=;
        b=I+uscPLC9xXpgiIodzDvB2NEN+5YGRdVSMP/p6OMBuC7OoSB11Sqik42gjuMjyVKdV
         Ux+k0gIy2nF7hDnKjIYCHl6BjKQWUx6cLyuk8wXvXJWQaqu4xQF91hIEatCjvgUQFj12
         /60eAUaRieP23XO8hjF4NUpha75JsK1HzK/a9sMMhZS+FR1r5DYcwyCFfV99fMRkthGu
         tY4CBJU41jMUCVSSevwUD8tyqDiZXl++qiqR+CFJmJev3Gu3das3teBVLOlWflL0VL+y
         0oVuKPYGdi7d3KHqjyw2mDnwow4jXYRviJMXR4V9ElTCJg2hdGmduWXmDUJol0V9z3uW
         XfDg==
X-Gm-Message-State: AOAM530tBi0MQcMSaX2T+POcsTBNVgTtphurXOhbkeAnU7u45IXgeBW2
        jd06PH3hA7YQACCr6q+mb3o4Xa7uSg==
X-Google-Smtp-Source: ABdhPJztfBf2qLY6rXo6eVAOY+UBltdFv38CUE8gB4tcGUPdUaDXNfkzI9Aq8jRoA00ZAR6vTkC5hg==
X-Received: by 2002:a9d:5f9d:: with SMTP id g29mr47487375oti.335.1638237589365;
        Mon, 29 Nov 2021 17:59:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l6sm2929052otu.12.2021.11.29.17.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 17:59:47 -0800 (PST)
Received: (nullmailer pid 1019098 invoked by uid 1000);
        Tue, 30 Nov 2021 01:59:46 -0000
Date:   Mon, 29 Nov 2021 19:59:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, yliu@xilinx.com,
        michal.simek@xilinx.com, stefanos@xilinx.com,
        devicetree@vger.kernel.org, trix@redhat.com, mdf@kernel.org,
        dwmw2@infradead.org, Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V2 XRT Alveo Infrastructure 4/9] of: create empty of root
Message-ID: <YaWFksVvfQQWqKcG@robh.at.kernel.org>
References: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
 <20211119222412.1092763-5-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119222412.1092763-5-lizhi.hou@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Nov 19, 2021 at 02:24:07PM -0800, Lizhi Hou wrote:
> When OF_FLATTREE is selected and there is not a device tree, create an
> empty device tree root node. of/unittest.c code is referenced.

What does the last sentence mean? You copied the code? If so, that's a 
sign you should refactor the unittest code to use this.

> 
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/of/Makefile        |  2 +-
>  drivers/of/fdt.c           | 20 ++++++++++++++++++++
>  drivers/of/fdt_default.dts |  5 +++++
>  drivers/of/of_private.h    |  5 +++++
>  4 files changed, 31 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/of/fdt_default.dts
> 
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index c13b982084a3..815f5220465b 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -2,7 +2,7 @@
>  obj-y = base.o device.o platform.o property.o
>  obj-$(CONFIG_OF_KOBJ) += kobj.o
>  obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
> -obj-$(CONFIG_OF_FLATTREE) += fdt.o
> +obj-$(CONFIG_OF_FLATTREE) += fdt.o fdt_default.dtb.o
>  obj-$(CONFIG_OF_EARLY_FLATTREE) += fdt_address.o
>  obj-$(CONFIG_OF_PROMTREE) += pdt.o
>  obj-$(CONFIG_OF_ADDRESS)  += address.o
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index d64445e43ceb..3d6e4543419e 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -481,6 +481,26 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
>  }
>  EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>  
> +static int __init of_fdt_root_init(void)
> +{
> +	struct device_node *np;
> +
> +	if (of_root)
> +		return 0;
> +
> +	if (!of_fdt_unflatten_tree((const unsigned long *)__dtb_fdt_default_begin,
> +				   NULL, &of_root)) {
> +		pr_warn("%s: unflatten default tree failed\n", __func__);
> +		return -ENODATA;
> +	}
> +
> +	for_each_of_allnodes(np)
> +		__of_attach_node_sysfs(np);
> +
> +	return 0;
> +}
> +late_initcall(of_fdt_root_init);
> +
>  /* Everything below here references initial_boot_params directly. */
>  int __initdata dt_root_addr_cells;
>  int __initdata dt_root_size_cells;
> diff --git a/drivers/of/fdt_default.dts b/drivers/of/fdt_default.dts
> new file mode 100644
> index 000000000000..d1f12a76dfc6
> --- /dev/null
> +++ b/drivers/of/fdt_default.dts
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +/ {
> +};
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 631489f7f8c0..47c6bb47ef25 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -41,6 +41,11 @@ extern struct mutex of_mutex;
>  extern struct list_head aliases_lookup;
>  extern struct kset *of_kset;
>  
> +#if defined(CONFIG_OF_FLATTREE)
> +extern u8 __dtb_fdt_default_begin[];
> +extern u8 __dtb_fdt_default_end[];
> +#endif
> +
>  #if defined(CONFIG_OF_DYNAMIC)
>  extern int of_property_notify(int action, struct device_node *np,
>  			      struct property *prop, struct property *old_prop);
> -- 
> 2.27.0
> 
> 
