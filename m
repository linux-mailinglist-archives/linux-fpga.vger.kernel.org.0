Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8003A266D
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFJIVB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 04:21:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:42089 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhFJIVB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 04:21:01 -0400
IronPort-SDR: RkDpl3KAOs739FwVPc7pv8D7boH3IZZ7YEcblbc2Ldvh90RComMvvSU1kYY2/NuuPlw5KvYloK
 kuPbDPcxbQVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="205213805"
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="205213805"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 01:19:04 -0700
IronPort-SDR: 388WwZRuhjAT8tpur5X7gtXf1guxn9sGBWpZVJAP3XuMgXkkY8mW4mZ2V7pq3EA4magSVjuAPS
 cdeTem0LHqtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="638283424"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jun 2021 01:19:01 -0700
Date:   Thu, 10 Jun 2021 16:13:22 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v2 6/8] fpga: mgr: Use standard dev_release for class
 driver
Message-ID: <20210610081322.GE2007225@yilunxu-OptiPlex-7050>
References: <20210609221135.261837-1-russell.h.weight@intel.com>
 <20210609221135.261837-7-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609221135.261837-7-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Looks good to me.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

On Wed, Jun 09, 2021 at 03:11:33PM -0700, Russ Weight wrote:
> The FPGA manager class driver data structure is being treated as a
> managed resource instead of using the class.dev_release call-back
> function to release the class data structure. This change populates
> the class.dev_release function, changes the fpga_mgr_free() function
> to call put_device() and changes the fpga_mgr_unregister() function
> to call device_del() instead of device_unregister().
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - Moved the renaming of "dev" to "parent" to a separate patch
>   - Call fpga_mgr_free() in devm_fpga_mgr_release() instead of put_device()
> ---
>  drivers/fpga/fpga-mgr.c | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 42ddc0844781..9f6c3760b6ff 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -585,8 +585,10 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
>  		return NULL;
>  
>  	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0)
> -		goto error_kfree;
> +	if (id < 0) {
> +		kfree(mgr);
> +		return NULL;
> +	}
>  
>  	mutex_init(&mgr->ref_mutex);
>  
> @@ -602,17 +604,12 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
>  	mgr->dev.id = id;
>  
>  	ret = dev_set_name(&mgr->dev, "fpga%d", id);
> -	if (ret)
> -		goto error_device;
> +	if (ret) {
> +		put_device(&mgr->dev);
> +		return NULL;
> +	}
>  
>  	return mgr;
> -
> -error_device:
> -	ida_simple_remove(&fpga_mgr_ida, id);
> -error_kfree:
> -	kfree(mgr);
> -
> -	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_create);
>  
> @@ -622,8 +619,7 @@ EXPORT_SYMBOL_GPL(fpga_mgr_create);
>   */
>  void fpga_mgr_free(struct fpga_manager *mgr)
>  {
> -	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> -	kfree(mgr);
> +	put_device(&mgr->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_free);
>  
> @@ -692,16 +688,11 @@ int fpga_mgr_register(struct fpga_manager *mgr)
>  
>  	ret = device_add(&mgr->dev);
>  	if (ret)
> -		goto error_device;
> +		return ret;
>  
>  	dev_info(&mgr->dev, "%s registered\n", mgr->name);
>  
>  	return 0;
> -
> -error_device:
> -	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> -
> -	return ret;
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_register);
>  
> @@ -722,7 +713,7 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
>  	if (mgr->mops->fpga_remove)
>  		mgr->mops->fpga_remove(mgr);
>  
> -	device_unregister(&mgr->dev);
> +	device_del(&mgr->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
>  
> @@ -781,6 +772,10 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
>  
>  static void fpga_mgr_dev_release(struct device *dev)
>  {
> +	struct fpga_manager *mgr = to_fpga_manager(dev);
> +
> +	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> +	kfree(mgr);
>  }
>  
>  static int __init fpga_mgr_class_init(void)
> -- 
> 2.25.1
