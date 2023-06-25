Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2677E73CF0E
	for <lists+linux-fpga@lfdr.de>; Sun, 25 Jun 2023 09:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjFYHxh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Jun 2023 03:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjFYHxg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 25 Jun 2023 03:53:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18161134;
        Sun, 25 Jun 2023 00:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687679616; x=1719215616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SoS0Nsh7ngvBqBbZ/bdTpGCiEvoUraZj2OMPU1oxgmg=;
  b=mEqE8sIbilDYpJ2yycaVPbnUmRv24B07rukQKYnlSAR9oJUlxQFWGWYj
   HkBfEwnYf6/Ccm0/qjHdHjVIzINFFEgdhDhGwGOQ9YBeb/5PYQV4rMfcn
   ddTQ2hfK9FpurER42XoMY0AhefW/1gdAz6cfAVZBBqj7V0nO9y+eKfyVX
   XDGUmD0y3d5e2qgZEU//icI/d/DGzuLJNBBZ1ukYvA3XVTXzp5eBeuUjs
   +hwh+Jp2d/XuzXfhg6nRHOatnTpO1M9WIyIALQ32hfA+KtoRbaxEDgMLp
   scTKfWi2MwHPYOlG0yglCtAv/Wj6DoF/iX4euo/dLMmQ9yO6NJRthnXfh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="447419518"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="447419518"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 00:53:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="693122380"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="693122380"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 25 Jun 2023 00:53:33 -0700
Date:   Sun, 25 Jun 2023 15:52:26 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v7 3/4] fpga: add an initial KUnit suite for the FPGA
 Region
Message-ID: <ZJfyOukVsxJtP3mi@yilunxu-OptiPlex-7050>
References: <20230616154405.220502-1-marpagan@redhat.com>
 <20230616154405.220502-4-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616154405.220502-4-marpagan@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-06-16 at 17:44:04 +0200, Marco Pagani wrote:
> The suite tests the basic behaviors of the FPGA Region including
> the programming and the function for finding a specific Region.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fpga-region-test.c | 211 ++++++++++++++++++++++++++
>  1 file changed, 211 insertions(+)
>  create mode 100644 drivers/fpga/tests/fpga-region-test.c
> 
> diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
> new file mode 100644
> index 000000000000..a502f3f2560d
> --- /dev/null
> +++ b/drivers/fpga/tests/fpga-region-test.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the FPGA Region
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <kunit/test.h>
> +#include <linux/platform_device.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/fpga/fpga-bridge.h>
> +#include <linux/fpga/fpga-region.h>

Ditto

> +
> +struct mgr_stats {
> +	u32 write_count;
> +};
> +
> +struct bridge_stats {
> +	bool enable;
> +	u32 cycles_count;
> +};
> +
> +struct test_ctx {
> +	struct fpga_manager *mgr;
> +	struct platform_device *mgr_pdev;
> +	struct fpga_bridge *bridge;
> +	struct platform_device *bridge_pdev;
> +	struct fpga_region *region;
> +	struct platform_device *region_pdev;
> +	struct bridge_stats bridge_stats;
> +	struct mgr_stats mgr_stats;
> +};
> +
> +static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +
> +	stats->write_count++;
> +
> +	return 0;
> +}
> +
> +/*
> + * Fake Manager that implements only the write op to count the number of
> + * programming cycles. The internals of the programming sequence are
> + * tested in the Manager suite since they are outside the responsibility
> + * of the Region.
> + */
> +static const struct fpga_manager_ops fake_mgr_ops = {
> +	.write = op_write,
> +};
> +
> +static int op_enable_set(struct fpga_bridge *bridge, bool enable)
> +{
> +	struct bridge_stats *stats = bridge->priv;
> +
> +	if (!stats->enable && enable)
> +		stats->cycles_count++;
> +
> +	stats->enable = enable;
> +
> +	return 0;
> +}
> +
> +/*
> + * Fake Bridge that implements only enable_set op to count the number of
> + * activation cycles.
> + */
> +static const struct fpga_bridge_ops fake_bridge_ops = {
> +	.enable_set = op_enable_set
                                   ^
I prefer to add the comma

Others LGTM.
Acked-by: Xu Yilun <yilun.xu@intel.com>
