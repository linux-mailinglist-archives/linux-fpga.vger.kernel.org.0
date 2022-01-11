Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A629F48A6D8
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Jan 2022 05:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiAKEhW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jan 2022 23:37:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:48511 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234012AbiAKEhW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 10 Jan 2022 23:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641875842; x=1673411842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CGnlIWPi/hH+iO9Qh4brMlKzt8eJJ01Gch7+Zshwins=;
  b=TslNHj/vgxuvnVnsS3iHgeajyGtCZOiWejXlYLQdvRUyzLJ3AEd+rPUt
   zZnepFHrtTmFcxEq/HuUSCTrEMpaCc3hDRpjSQ7g4e8wZVpnGMj3NH97h
   3q96nEP3kFj5VmMmw/GVx3hfF+kyf+tY9TQVqAK/4nzQ8YTUGQYfUL5Y+
   MOgBeUGWJ/KhYdapwAztQghH00Zk0Rd5MBCYM6Ke6DFfPeoSCfkDLEjDm
   to4R5qE4fxbm40W73F/H75O7S1kGNEx95Ou0VCyLsj9cBRnNXCF7xsSy3
   McZgJTNk40jpR5wtC7nyvsN6uKskoKJWOCa2LfXdH7E1mwUVSxGDvDqck
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="304137919"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="304137919"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 20:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="474388889"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by orsmga006.jf.intel.com with ESMTP; 10 Jan 2022 20:37:14 -0800
Date:   Tue, 11 Jan 2022 12:29:20 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, yliu@xilinx.com,
        michal.simek@xilinx.com, stefanos@xilinx.com,
        devicetree@vger.kernel.org, trix@redhat.com, mdf@kernel.org,
        robh@kernel.org, dwmw2@infradead.org,
        Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V4 XRT Alveo Infrastructure 3/5] of: create empty of root
Message-ID: <20220111042920.GA979169@yilunxu-OptiPlex-7050>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
 <20220105225013.1567871-4-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105225013.1567871-4-lizhi.hou@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jan 05, 2022 at 02:50:11PM -0800, Lizhi Hou wrote:
> When OF_FLATTREE is selected and there is not a device tree, create an
> empty device tree root node. of/unittest.c code is referenced.
> 
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/of/Makefile        |  5 +++
>  drivers/of/fdt.c           | 90 ++++++++++++++++++++++++++++++++++++++
>  drivers/of/fdt_default.dts |  5 +++
>  drivers/of/of_private.h    | 17 +++++++
>  drivers/of/unittest.c      | 72 ++----------------------------
>  5 files changed, 120 insertions(+), 69 deletions(-)
>  create mode 100644 drivers/of/fdt_default.dts
> 
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index c13b982084a3..a2989055c578 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y = base.o device.o platform.o property.o
> +

remove the blank line.

>  obj-$(CONFIG_OF_KOBJ) += kobj.o
>  obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
>  obj-$(CONFIG_OF_FLATTREE) += fdt.o
> @@ -20,4 +21,8 @@ obj-y	+= kexec.o
>  endif
>  endif
>  
> +ifndef CONFIG_OF_UNITTEST
> +obj-$(CONFIG_OF_FLATTREE) += fdt_default.dtb.o
> +endif
> +

Same question as Tom, the unittest should work well with or without
of_root, is it? So creating an empty root will not affect unittest, so
why so many ifdefs for CONFIG_OF_UNITTEST?

>  obj-$(CONFIG_OF_UNITTEST) += unittest-data/
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 4546572af24b..66ef9ac97829 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -466,6 +466,96 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
>  }
>  EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
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

It's confusing to me. If we need to share some functions with unittest,
make a new clearly defined (and named) function.

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

Is it better we have a new Kconfig option for the empty tree creation.

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
> index 631489f7f8c0..1ef93bccfdba 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -41,6 +41,18 @@ extern struct mutex of_mutex;
>  extern struct list_head aliases_lookup;
>  extern struct kset *of_kset;
>  
> +#if defined(CONFIG_OF_UNITTEST)
> +extern u8 __dtb_testcases_begin[];
> +extern u8 __dtb_testcases_end[];
> +#define __dtb_fdt_default_begin		__dtb_testcases_begin
> +#define __dtb_fdt_default_end		__dtb_testcases_end

Maybe we don't have to use the test dt data, stick to the default empty
fdt is fine?

> +void __init unittest_data_add(struct device_node *dt);
> +#else
> +extern u8 __dtb_fdt_default_begin[];
> +extern u8 __dtb_fdt_default_end[];
> +static inline void unittest_data_add(struct device_node *dt) {}
> +#endif
> +
>  #if defined(CONFIG_OF_DYNAMIC)
>  extern int of_property_notify(int action, struct device_node *np,
>  			      struct property *prop, struct property *old_prop);
> @@ -84,6 +96,11 @@ static inline void __of_detach_node_sysfs(struct device_node *np) {}
>  
>  #if defined(CONFIG_OF_RESOLVE)
>  int of_resolve_phandles(struct device_node *tree);
> +#else
> +static inline int of_resolve_phandles(struct device_node *tree)
> +{
> +	return 0;
> +}

If we have an empty of_resolve_phandles, does the empty tree creation
still works? Or if we don't need this func, just delete in the code.

Thanks,
Yilun

>  #endif
>  
>  void __of_phandle_cache_inv_entry(phandle handle);
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 8c056972a6dd..745f455235cc 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1402,73 +1402,15 @@ static void attach_node_and_children(struct device_node *np)
>   *	unittest_data_add - Reads, copies data from
>   *	linked tree and attaches it to the live tree
>   */
> -static int __init unittest_data_add(void)
> +void __init unittest_data_add(struct device_node *dt)
>  {
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
>  	EXPECT_BEGIN(KERN_INFO,
>  		     "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
>  
>  	/* attach the sub-tree to live tree */
> -	np = unittest_data_node->child;
> +	np = dt->child;
>  	while (np) {
>  		struct device_node *next = np->sibling;
>  
> @@ -1479,10 +1421,6 @@ static int __init unittest_data_add(void)
>  
>  	EXPECT_END(KERN_INFO,
>  		   "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
> -
> -	of_overlay_mutex_unlock();
> -
> -	return 0;
>  }
>  
>  #ifdef CONFIG_OF_OVERLAY
> @@ -3258,7 +3196,6 @@ static inline __init void of_unittest_overlay_high_level(void) {}
>  static int __init of_unittest(void)
>  {
>  	struct device_node *np;
> -	int res;
>  
>  	pr_info("start of unittest - you will see error messages\n");
>  
> @@ -3267,9 +3204,6 @@ static int __init of_unittest(void)
>  	if (IS_ENABLED(CONFIG_UML))
>  		unittest_unflatten_overlay_base();
>  
> -	res = unittest_data_add();
> -	if (res)
> -		return res;
>  	if (!of_aliases)
>  		of_aliases = of_find_node_by_path("/aliases");
>  
> -- 
> 2.27.0
