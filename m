Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A67488BAB
	for <lists+linux-fpga@lfdr.de>; Sun,  9 Jan 2022 19:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiAISkB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 9 Jan 2022 13:40:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236516AbiAISkA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 9 Jan 2022 13:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641753598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPUWhZLF+lxT83zyd+U+d507S3IZFMBvdYyM13/r3xc=;
        b=Q1wdZ8IzIZXouzA+XlOUTjEeA4RZgYj1zP2xthxZO4IwqjXjg64rhXxcwNF8lQD1uUWUA/
        H0chMCj+3XOSIkyOpEHeaFFRjJabBtBYEbf0fN85OncCNv0m7FubdmE+MK5C7PRRrenAMp
        qbxXX9xOxVryyTZGjP77xDCFTxAOExo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-opUdW4rbMJmVh5yvPUk3kw-1; Sun, 09 Jan 2022 13:39:57 -0500
X-MC-Unique: opUdW4rbMJmVh5yvPUk3kw-1
Received: by mail-oi1-f199.google.com with SMTP id r65-20020aca4444000000b002bce52a8122so8510956oia.14
        for <linux-fpga@vger.kernel.org>; Sun, 09 Jan 2022 10:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NPUWhZLF+lxT83zyd+U+d507S3IZFMBvdYyM13/r3xc=;
        b=SYrgVQ1iWMbeBTF0th8C4hWSRqy6qAEg/nll5HMSxSWQ8E+V6fAddakI5VQH2Lu/tc
         Da+W+JVSEho+sBbvKjTbnSEvDYmjOo/dUhqgqUAA8bD13NwoHZ46Ezx334sPeT+Kx96/
         1YuxDoxiautJmE3h/EfYXY17x/twBXed3yeF2O6mrv+TLgEWD3pnC5pJh3jepS2Fn2LE
         JAgAo0hZRgEcJT4MKMxbQsI9IYaUaKX8yXQaMQy5xFyaTPTRSrEi1SNw/G6Wo7wcmg++
         SCZwQXU+b8tMSWNO3EBkk+P6majkDqekb2Z7DAcpIHrzJ5NIT7FyUIQrKvzixQWhYc58
         SlYQ==
X-Gm-Message-State: AOAM532R81yku3Gk90Cap6v6thGcpbUGUXuFaf5UqZ0hFaJXtpq6Dd0n
        AMCKImX/OTbjgBGE14epInBaNQOMxSW9VQpsE5E0rAD3eJSFxQX/0VP0vPTik2PYta7rJL7szw4
        HcCUh6saF+arTE13E56KM/Q==
X-Received: by 2002:a05:6830:25d6:: with SMTP id d22mr2982709otu.103.1641753596832;
        Sun, 09 Jan 2022 10:39:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfNK+E2M5R0uUiK5MDpQD1yo8fGyPI4Cp4zUl8TXeygU+15BvvqdaMn5/LwsiShA+1rIJFbw==
X-Received: by 2002:a05:6830:25d6:: with SMTP id d22mr2982702otu.103.1641753596617;
        Sun, 09 Jan 2022 10:39:56 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id f7sm1029185oti.35.2022.01.09.10.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 10:39:56 -0800 (PST)
Subject: Re: [PATCH V4 XRT Alveo Infrastructure 3/5] of: create empty of root
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, dwmw2@infradead.org,
        Max Zhen <max.zhen@xilinx.com>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
 <20220105225013.1567871-4-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <fb65ee24-00e2-dac3-6af8-25f39bcd7a08@redhat.com>
Date:   Sun, 9 Jan 2022 10:39:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220105225013.1567871-4-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/5/22 2:50 PM, Lizhi Hou wrote:
> When OF_FLATTREE is selected and there is not a device tree, create an
> empty device tree root node. of/unittest.c code is referenced.

Looks like this patch is doing two things, creating the empty node and 
refactoring the unit tests.

This patch should be split.

It is not clear why the unit test should be refactored.

Tom

>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   drivers/of/Makefile        |  5 +++
>   drivers/of/fdt.c           | 90 ++++++++++++++++++++++++++++++++++++++
>   drivers/of/fdt_default.dts |  5 +++
>   drivers/of/of_private.h    | 17 +++++++
>   drivers/of/unittest.c      | 72 ++----------------------------
>   5 files changed, 120 insertions(+), 69 deletions(-)
>   create mode 100644 drivers/of/fdt_default.dts
>
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index c13b982084a3..a2989055c578 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-y = base.o device.o platform.o property.o
> +
extra lf, remove
>   obj-$(CONFIG_OF_KOBJ) += kobj.o
>   obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
>   obj-$(CONFIG_OF_FLATTREE) += fdt.o
> @@ -20,4 +21,8 @@ obj-y	+= kexec.o
>   endif
>   endif
>   
> +ifndef CONFIG_OF_UNITTEST
> +obj-$(CONFIG_OF_FLATTREE) += fdt_default.dtb.o
> +endif
> +
>   obj-$(CONFIG_OF_UNITTEST) += unittest-data/
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 4546572af24b..66ef9ac97829 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -466,6 +466,96 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
>   }
>   EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>   
> +static int __init of_fdt_root_init(void)
> +{
> +	struct device_node *dt = NULL, *np;
> +	void *fdt = NULL, *fdt_aligned;
> +	struct property *prop = NULL;
> +	__be32 *val = NULL;
> +	int size, rc = 0;
> +
> +#if !defined(CONFIG_OF_UNITTEST)
> +	if (of_root)
> +		return 0;
> +#endif
> +	size = __dtb_fdt_default_end - __dtb_fdt_default_begin;
> +
> +	fdt = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
> +	if (!fdt)
> +		return -ENOMEM;
> +
> +	fdt_aligned = PTR_ALIGN(fdt, FDT_ALIGN_SIZE);
> +	memcpy(fdt_aligned, __dtb_fdt_default_begin, size);
> +
> +	if (!of_fdt_unflatten_tree((const unsigned long *)fdt_aligned,
> +				   NULL, &dt)) {
> +		pr_warn("%s: unflatten default tree failed\n", __func__);
> +		kfree(fdt);
> +		return -ENODATA;
> +	}
> +	if (!dt) {
> +		pr_warn("%s: empty default tree\n", __func__);
> +		kfree(fdt);
> +		return -ENODATA;
> +	}
> +
> +	/*
> +	 * This lock normally encloses of_resolve_phandles()
> +	 */
> +	of_overlay_mutex_lock();
> +
> +	rc = of_resolve_phandles(dt);
> +	if (rc) {
> +		pr_err("%s: Failed to resolve phandles (rc=%i)\n", __func__, rc);
> +		goto failed;
> +	}
> +
> +	if (!of_root) {
> +		prop = kcalloc(2, sizeof(*prop), GFP_KERNEL);
> +		if (!prop) {
> +			rc = -ENOMEM;
> +			goto failed;
> +		}
> +		val = kzalloc(sizeof(*val), GFP_KERNEL);
> +		if (!val) {
> +			rc = -ENOMEM;
> +			goto failed;
> +		}
> +		*val = cpu_to_be32(sizeof(void *) / sizeof(u32));
> +
> +		prop->name = "#address-cells";
> +		prop->value = val;
> +		prop->length = sizeof(u32);
> +		of_add_property(dt, prop);
> +		prop++;
> +		prop->name = "#size-cells";
> +		prop->value = val;
> +		prop->length = sizeof(u32);
> +		of_add_property(dt, prop);
> +		of_root = dt;
> +		for_each_of_allnodes(np)
> +			__of_attach_node_sysfs(np);
> +		of_aliases = of_find_node_by_path("/aliases");
> +		of_chosen = of_find_node_by_path("/chosen");
> +		of_overlay_mutex_unlock();
> +pr_info("OF ROOT FLAG %lx\n", of_root->_flags);
> +		return 0;
> +	}
> +
> +	unittest_data_add(dt);
> +
> +	of_overlay_mutex_unlock();
> +
> +	return 0;
> +
> +failed:
> +	of_overlay_mutex_unlock();
> +	kfree(val);
> +	kfree(prop);
> +	return rc;
> +}
> +pure_initcall(of_fdt_root_init);
> +
>   /* Everything below here references initial_boot_params directly. */
>   int __initdata dt_root_addr_cells;
>   int __initdata dt_root_size_cells;
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
> index 631489f7f8c0..1ef93bccfdba 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -41,6 +41,18 @@ extern struct mutex of_mutex;
>   extern struct list_head aliases_lookup;
>   extern struct kset *of_kset;
>   
> +#if defined(CONFIG_OF_UNITTEST)
> +extern u8 __dtb_testcases_begin[];
> +extern u8 __dtb_testcases_end[];
> +#define __dtb_fdt_default_begin		__dtb_testcases_begin
> +#define __dtb_fdt_default_end		__dtb_testcases_end
> +void __init unittest_data_add(struct device_node *dt);
> +#else
> +extern u8 __dtb_fdt_default_begin[];
> +extern u8 __dtb_fdt_default_end[];
> +static inline void unittest_data_add(struct device_node *dt) {}
> +#endif
> +
>   #if defined(CONFIG_OF_DYNAMIC)
>   extern int of_property_notify(int action, struct device_node *np,
>   			      struct property *prop, struct property *old_prop);
> @@ -84,6 +96,11 @@ static inline void __of_detach_node_sysfs(struct device_node *np) {}
>   
>   #if defined(CONFIG_OF_RESOLVE)
>   int of_resolve_phandles(struct device_node *tree);
> +#else
> +static inline int of_resolve_phandles(struct device_node *tree)
> +{
> +	return 0;
> +}
>   #endif
>   
>   void __of_phandle_cache_inv_entry(phandle handle);
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 8c056972a6dd..745f455235cc 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1402,73 +1402,15 @@ static void attach_node_and_children(struct device_node *np)
>    *	unittest_data_add - Reads, copies data from
>    *	linked tree and attaches it to the live tree
>    */
> -static int __init unittest_data_add(void)
> +void __init unittest_data_add(struct device_node *dt)
>   {
> -	void *unittest_data;
> -	void *unittest_data_align;
> -	struct device_node *unittest_data_node = NULL, *np;
> -	/*
> -	 * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
> -	 * created by cmd_dt_S_dtb in scripts/Makefile.lib
> -	 */
> -	extern uint8_t __dtb_testcases_begin[];
> -	extern uint8_t __dtb_testcases_end[];
> -	const int size = __dtb_testcases_end - __dtb_testcases_begin;
> -	int rc;
> -	void *ret;
> -
> -	if (!size) {
> -		pr_warn("%s: testcases is empty\n", __func__);
> -		return -ENODATA;
> -	}
> -
> -	/* creating copy */
> -	unittest_data = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
> -	if (!unittest_data)
> -		return -ENOMEM;
> -
> -	unittest_data_align = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
> -	memcpy(unittest_data_align, __dtb_testcases_begin, size);
> -
> -	ret = of_fdt_unflatten_tree(unittest_data_align, NULL, &unittest_data_node);
> -	if (!ret) {
> -		pr_warn("%s: unflatten testcases tree failed\n", __func__);
> -		kfree(unittest_data);
> -		return -ENODATA;
> -	}
> -	if (!unittest_data_node) {
> -		pr_warn("%s: testcases tree is empty\n", __func__);
> -		kfree(unittest_data);
> -		return -ENODATA;
> -	}
> -
> -	/*
> -	 * This lock normally encloses of_resolve_phandles()
> -	 */
> -	of_overlay_mutex_lock();
> -
> -	rc = of_resolve_phandles(unittest_data_node);
> -	if (rc) {
> -		pr_err("%s: Failed to resolve phandles (rc=%i)\n", __func__, rc);
> -		of_overlay_mutex_unlock();
> -		return -EINVAL;
> -	}
> -
> -	if (!of_root) {
> -		of_root = unittest_data_node;
> -		for_each_of_allnodes(np)
> -			__of_attach_node_sysfs(np);
> -		of_aliases = of_find_node_by_path("/aliases");
> -		of_chosen = of_find_node_by_path("/chosen");
> -		of_overlay_mutex_unlock();
> -		return 0;
> -	}
> +	struct device_node *np;
>   
>   	EXPECT_BEGIN(KERN_INFO,
>   		     "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
>   
>   	/* attach the sub-tree to live tree */
> -	np = unittest_data_node->child;
> +	np = dt->child;
>   	while (np) {
>   		struct device_node *next = np->sibling;
>   
> @@ -1479,10 +1421,6 @@ static int __init unittest_data_add(void)
>   
>   	EXPECT_END(KERN_INFO,
>   		   "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
> -
> -	of_overlay_mutex_unlock();
> -
> -	return 0;
>   }
>   
>   #ifdef CONFIG_OF_OVERLAY
> @@ -3258,7 +3196,6 @@ static inline __init void of_unittest_overlay_high_level(void) {}
>   static int __init of_unittest(void)
>   {
>   	struct device_node *np;
> -	int res;
>   
>   	pr_info("start of unittest - you will see error messages\n");
>   
> @@ -3267,9 +3204,6 @@ static int __init of_unittest(void)
>   	if (IS_ENABLED(CONFIG_UML))
>   		unittest_unflatten_overlay_base();
>   
> -	res = unittest_data_add();
> -	if (res)
> -		return res;
>   	if (!of_aliases)
>   		of_aliases = of_find_node_by_path("/aliases");
>   

