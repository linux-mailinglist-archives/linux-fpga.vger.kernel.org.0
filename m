Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B873A1A3E
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 17:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhFIP6Z (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 11:58:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:31882 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhFIP6Y (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 11:58:24 -0400
IronPort-SDR: o4LIs13IWDD3bVNRXNXrx0E9sPqTRv7C6aYtmBZFJJnuWqNZsjMqYb9xDD7PIwifZJa6iuZcUY
 4tnVU8iXa7XQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202075892"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="202075892"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 08:56:26 -0700
IronPort-SDR: fpWLAL1ioJl5Ex5MHHn3kzV3vxNMlsolgvup2QmHZql1DvTX29NY3xEoWEXacKm6QTs0e60P6l
 YWRBzjFJvyxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="485774574"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2021 08:56:24 -0700
Date:   Wed, 9 Jun 2021 23:50:45 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v1 3/5] fpga: stratix10-soc: Add missing fpga_mgr_free()
 call
Message-ID: <20210609155045.GC1994229@yilunxu-OptiPlex-7050>
References: <20210609004925.238044-1-russell.h.weight@intel.com>
 <20210609004925.238044-4-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609004925.238044-4-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Looks good to me.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

On Tue, Jun 08, 2021 at 05:49:23PM -0700, Russ Weight wrote:
> The stratix10-soc driver uses fpga_mgr_create() function and is therefore
> responsible to call fpga_mgr_free() to release the class driver resources.
> Add a missing call to fpga_mgr_free in the s10_remove() function.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/stratix10-soc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 657a70c5fc99..9e34bbbce26e 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -454,6 +454,7 @@ static int s10_remove(struct platform_device *pdev)
>  	struct s10_priv *priv = mgr->priv;
>  
>  	fpga_mgr_unregister(mgr);
> +	fpga_mgr_free(mgr);
>  	stratix10_svc_free_channel(priv->chan);
>  
>  	return 0;
> -- 
> 2.25.1
