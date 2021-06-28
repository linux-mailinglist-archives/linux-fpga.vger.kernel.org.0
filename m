Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658403B5AEA
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 11:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhF1JJl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 05:09:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:58429 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232284AbhF1JJk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Jun 2021 05:09:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="207734697"
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="207734697"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 02:07:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="446493241"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga007.jf.intel.com with ESMTP; 28 Jun 2021 02:07:05 -0700
Date:   Mon, 28 Jun 2021 17:01:46 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     will@kernel.org, hao.wu@intel.com, mark.rutland@arm.com,
        trix@redhat.com, luwei.kang@intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, maddy@linux.vnet.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, rnsastry@linux.ibm.com
Subject: Re: [RFC] fpga: dfl: fme: Fix cpu hotplug code
Message-ID: <20210628090146.GA80012@yilunxu-OptiPlex-7050>
References: <20210628071546.167088-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628071546.167088-1-kjain@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

It's a good fix, you can drop the RFC in commit title. :)

The title could be more specific, like:

    fpga: dfl: fme: Fix cpu hotplug issue in performance reporting

So we know it is for performance reporting feature at first glance.

On Mon, Jun 28, 2021 at 12:45:46PM +0530, Kajol Jain wrote:

> Commit 724142f8c42a ("fpga: dfl: fme: add performance
> reporting support") added performance reporting support
> for FPGA management engine via perf.

May drop this section, it is indicated in the Fixes tag.

> 
> It also added cpu hotplug feature but it didn't add

The performance reporting driver added cpu hotplug ...

> pmu migration call in cpu offline function.
> This can create an issue incase the current designated
> cpu being used to collect fme pmu data got offline,
> as based on current code we are not migrating fme pmu to
> new target cpu. Because of that perf will still try to
> fetch data from that offline cpu and hence we will not
> get counter data.
> 
> Patch fixed this issue by adding pmu_migrate_context call
> in fme_perf_offline_cpu function.
> 
> Fixes: 724142f8c42a ("fpga: dfl: fme: add performance reporting support")
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

Tested-by: Xu Yilun <yilun.xu@intel.com>

Thanks,
Yilun

> ---
>  drivers/fpga/dfl-fme-perf.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> ---
> - This fix patch is not tested (as I don't have required environment).
>   But issue mentioned in the commit msg can be re-created, by starting any
>   fme_perf event and while its still running, offline current designated
>   cpu pointed by cpumask file. Since current code didn't migrating pmu,
>   perf gonna try getting counts from that offlined cpu and hence we will
>   not get event data.
> ---
> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> index 4299145ef347..b9a54583e505 100644
> --- a/drivers/fpga/dfl-fme-perf.c
> +++ b/drivers/fpga/dfl-fme-perf.c
> @@ -953,6 +953,10 @@ static int fme_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  		return 0;
>  
>  	priv->cpu = target;
> +
> +	/* Migrate fme_perf pmu events to the new target cpu */
> +	perf_pmu_migrate_context(&priv->pmu, cpu, target);
> +
>  	return 0;
>  }
>  
> -- 
> 2.31.1
