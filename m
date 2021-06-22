Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35773AFF9D
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Jun 2021 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhFVIxZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Jun 2021 04:53:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:15845 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhFVIxY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 22 Jun 2021 04:53:24 -0400
IronPort-SDR: d4RXuug27Iq4OqP8IhpXY1PzyHbgUxF2koQkM/b/qYtNeeXgXAqgDcDRFUM1gk99MnGELFf+ug
 Uqvy7g8jNp0w==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="194323371"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="194323371"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 01:50:35 -0700
IronPort-SDR: ZdtyY8m3KuPtKcm/cnJJxsR/nc87DwIcHlVdBDOiF0zEcm1DGa/CFswR2vd/nDGLxlXDsxcR7f
 ut6MohW5u9Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="490206701"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2021 01:50:32 -0700
Date:   Tue, 22 Jun 2021 16:45:15 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v6 1/3] fpga: mgr: Use standard dev_release for class
 driver
Message-ID: <20210622084515.GB29169@yilunxu-OptiPlex-7050>
References: <20210621222249.451387-1-russell.h.weight@intel.com>
 <20210621222249.451387-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621222249.451387-2-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Some more comments.

On Mon, Jun 21, 2021 at 03:22:47PM -0700, Russ Weight wrote:
> +struct fpga_manager *
> +fpga_mgr_register(struct device *parent, struct fpga_manager_info *info)
>  {
> +	const struct fpga_manager_ops *mops = info->mops;
>  	struct fpga_manager *mgr;
>  	int id, ret;
>  
> @@ -572,29 +570,31 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,

Shall we add the check?

	if (!mops || ...)

>  	    !mops->write_init || (!mops->write && !mops->write_sg) ||
>  	    (mops->write && mops->write_sg)) {
>  		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>

[...]
  
> +struct fpga_manager *
> +fpga_mgr_register(struct device *dev, struct fpga_manager_info *info);

		     struct device *parent, const struct fpga_manager_info

>  
> -int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
> +struct fpga_manager *
> +fpga_mgr_register_simple(struct device *dev, const char *name,

			    struct device *parent,

> +			 const struct fpga_manager_ops *mops, void *priv);
> +void fpga_mgr_unregister(struct fpga_manager *mgr);
>  
> -struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
> -					  const struct fpga_manager_ops *mops,
> -					  void *priv);
> +struct fpga_manager *
> +devm_fpga_mgr_register(struct device *dev, struct fpga_manager_info *info);


			  struct device *parent, const struct fpga_manager_info

> +struct fpga_manager *
> +devm_fpga_mgr_register_simple(struct device *dev, const char *name,

				 struct device *parent,

> +			      const struct fpga_manager_ops *mops, void *priv);
>  
>  #endif /*_LINUX_FPGA_MGR_H */
> -- 
> 2.25.1
