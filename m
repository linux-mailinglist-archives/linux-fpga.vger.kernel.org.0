Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F262D462A09
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Nov 2021 02:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhK3CAo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Nov 2021 21:00:44 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:37678 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbhK3CAj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 Nov 2021 21:00:39 -0500
Received: by mail-oo1-f49.google.com with SMTP id v19-20020a4a2453000000b002bb88bfb594so6246231oov.4;
        Mon, 29 Nov 2021 17:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K6tFSuYZjq4zzwBFopKtf7pBXmFwiVkXCYs6ENTtgC8=;
        b=cet4nZI4c4ds3iIKRm/Y6UF7qowOLiCo49J5fxIVWGdxQqTAvEZ2ltWZMBUbWxJo19
         jA501DNh5PhHLbBp37QefiMOsc5Dj7vnkuRjKzX+C7PFdWQ+EPCO4fkeX4chSjjqEQ5x
         2GwzJuk+pnJHq+nk0t+3OmAosqdA2gIekyfcIpiuZTuAtAJ9Znp52J/wXIslS9+S/aro
         CpRs3UCOHtkImWVhIZzSL2JbL1b4hnN/Rp/TH98mzkNjlnXz5gUiIMamqC+3kKAVqd3S
         h0/16VpgDbzHwy8lJqIsJivsmY2Esr6GStqW/L36ZjvYAWUO2qwByb/Qk9L3HVJGutUh
         m7vg==
X-Gm-Message-State: AOAM532mBJDgCdNgqcbGV1iFKUskvurSnwltdh4EEuFlq5YWLVZKUf77
        bbui2oCLfT7Lp7devMJZIA==
X-Google-Smtp-Source: ABdhPJwyQUjhBj7QFjKWhI2v5QuKToynR3JIRtb3Epp1EqdfASkWTdDdi1trTv6fsV3MThiFZBzdgA==
X-Received: by 2002:a4a:e701:: with SMTP id y1mr33694681oou.42.1638237440576;
        Mon, 29 Nov 2021 17:57:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n26sm1062405ooc.48.2021.11.29.17.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 17:57:20 -0800 (PST)
Received: (nullmailer pid 1015641 invoked by uid 1000);
        Tue, 30 Nov 2021 01:57:19 -0000
Date:   Mon, 29 Nov 2021 19:57:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, yliu@xilinx.com,
        michal.simek@xilinx.com, stefanos@xilinx.com,
        devicetree@vger.kernel.org, trix@redhat.com, mdf@kernel.org,
        dwmw2@infradead.org, Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V2 XRT Alveo Infrastructure 3/9] of: handle fdt buffer
 alignment inside unflatten function
Message-ID: <YaWE/2ikgpXi2hzY@robh.at.kernel.org>
References: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
 <20211119222412.1092763-4-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119222412.1092763-4-lizhi.hou@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Nov 19, 2021 at 02:24:06PM -0800, Lizhi Hou wrote:
> Add alignment check to of_fdt_unflatten_tree(). If it is not aligned,
> allocate a aligned buffer and copy the fdt blob. So the caller does not
> have to deal with the buffer alignment before calling this function.
> XRT uses this function to unflatten fdt which is from Alveo firmware.
> 
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/of/fdt.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 4546572af24b..d64445e43ceb 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -455,13 +455,28 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
>  			    struct device_node *dad,
>  			    struct device_node **mynodes)
>  {
> +	void *new_fdt = NULL, *fdt_align;
>  	void *mem;
>  
> +	if (fdt_check_header(blob)) {
> +		pr_err("Invalid fdt blob\n");
> +		return NULL;
> +	}
> +	fdt_align = (void *)PTR_ALIGN(blob, FDT_ALIGN_SIZE);
> +	if (fdt_align != blob) {
> +		new_fdt = kmalloc(fdt_totalsize(blob) + FDT_ALIGN_SIZE, GFP_KERNEL);
> +		if (!new_fdt)
> +			return NULL;
> +		fdt_align = PTR_ALIGN(new_fdt, FDT_ALIGN_SIZE);

Where's the copy?

> +	}
> +
>  	mutex_lock(&of_fdt_unflatten_mutex);
> -	mem = __unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc,
> +	mem = __unflatten_device_tree(fdt_align, dad, mynodes, &kernel_tree_alloc,
>  				      true);
>  	mutex_unlock(&of_fdt_unflatten_mutex);
>  
> +	kfree(new_fdt);

You know the unflattened DT just references strings and property values 
from the flattened DT. So you just caused a use after free.

Fix your firmware to align the DT.

Rob
