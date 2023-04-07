Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0596DA922
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Apr 2023 08:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjDGGyr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 7 Apr 2023 02:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjDGGyq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 7 Apr 2023 02:54:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D17ED3;
        Thu,  6 Apr 2023 23:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680850485; x=1712386485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O6E6owGrMJFj88FaaF7QG/CD6iTO8b8i6HJZ/FX+014=;
  b=XI2DiuJLhPuLb9Z3c6loIo49t/cwLVNIruJd8TMBzYD5D5IocKJ4kv4s
   Sks/VPyYjzXERchKH3ssP20eD095Zc+X7Pz9Lae1ybSBKoDOBlztQQBEN
   88OXwZP+lIC3o75VT/ElPGHsjS+X1++z/hQ/InYoLtck9OVj+VDjmkhEX
   s/iPvk9ltgfubPSrMy9fWI0jQC/sqqvU6rLiQ0kNxQvxEYs+OVtYkQCsY
   PK+/AVA//evLKuAxP+C320HINSnTGN4sZF42fQ+Bx+psnkhmhdc7T9dnT
   hvzCHref9tRHQ6K0R3PoYW4yy09z+EPVxbd6UqrwXnGYlTZ71XTWwZ/rJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="405755644"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="405755644"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 23:54:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="831097172"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="831097172"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 06 Apr 2023 23:54:31 -0700
Date:   Fri, 7 Apr 2023 14:42:51 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linuxarm@huawei.com, Dan Williams <dan.j.williams@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Robert Richter <rric@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Frank Li <Frank.li@nxp.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liang Kan <kan.liang@linux.intel.com>
Subject: Re: [PATCH 29/32] fpga: dfl: Assign parent for event_source device
Message-ID: <ZC+7a/hUe1qpUsDv@yilunxu-OptiPlex-7050>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
 <20230404134225.13408-30-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404134225.13408-30-Jonathan.Cameron@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-04 at 14:42:22 +0100, Jonathan Cameron wrote:
> Currently the PMU device appears directly under /sys/devices/
> Only root busses should appear there, so instead assign the pmu->dev
> parent to be the Platform device.
> 
> Link: https://lore.kernel.org/linux-cxl/ZCLI9A40PJsyqAmq@kroah.com/
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: linux-fpga@vger.kernel.org
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  drivers/fpga/dfl-fme-perf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> index 7422d2bc6f37..2d59f1c620b1 100644
> --- a/drivers/fpga/dfl-fme-perf.c
> +++ b/drivers/fpga/dfl-fme-perf.c
> @@ -912,6 +912,7 @@ static int fme_perf_pmu_register(struct platform_device *pdev,
>  
>  	fme_perf_setup_hardware(priv);
>  
> +	pmu->parent =		&pdev->dev;
>  	pmu->task_ctx_nr =	perf_invalid_context;
>  	pmu->attr_groups =	fme_perf_groups;
>  	pmu->attr_update =	fme_perf_events_groups;
> -- 
> 2.37.2
> 
