Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BA574FCEC
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Jul 2023 04:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjGLCBu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Jul 2023 22:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGLCBt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 11 Jul 2023 22:01:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E8BE7E;
        Tue, 11 Jul 2023 19:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689127308; x=1720663308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tnDgXuyxN6TFU9q9l7GfKXwskzKHJdUAYGiVK1N0+ME=;
  b=Mci8O9yO6zoJ8HYJiaGncfaTQ9Uj2jZwQAOHPjIL6GgvZwdNg8KiYf6o
   c/KvkUZUJmNcPK4b+QW0X0Uh7lsiYA5gL8ppR4Amp7/twICWbejFQexxe
   3FeIdK4BuE7JK9GmleY1Y8MXH+U1fm/vfrZ95kHLzhXDtkNkHcWioDK5B
   /cpNQU/FTbaZxYSD+neC+Zxp0v94/djdLizrUxWyX6LfR8CaMzHHpYRuv
   oBFeD/OQW8ZGo1mPrI60LrH7q0vWv6jRHXzi0qzshQv9iP+SZsWUU4mlt
   6pupn/4/hHIFSMP1hvBr9NfOwg6qMo4CQMucRzN31HjfQIBPfK2uGKm7o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362247653"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="362247653"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 19:01:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="786858030"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="786858030"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2023 19:01:46 -0700
Date:   Wed, 12 Jul 2023 10:00:16 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v8 1/4] fpga: add an initial KUnit suite for the FPGA
 Manager
Message-ID: <ZK4JMDZfdVyFkN92@yilunxu-OptiPlex-7050>
References: <20230630152507.30219-1-marpagan@redhat.com>
 <20230630152507.30219-2-marpagan@redhat.com>
 <ZKuMosEu242BrY0K@yilunxu-OptiPlex-7050>
 <1d03a695-d603-a4d5-b726-4b0ff6bc33f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d03a695-d603-a4d5-b726-4b0ff6bc33f8@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-07-11 at 16:02:44 +0200, Marco Pagani wrote:
> 
> 
> On 2023-07-10 06:44, Xu Yilun wrote:
> > On 2023-06-30 at 17:25:04 +0200, Marco Pagani wrote:
> >> The suite tests the basic behaviors of the FPGA Manager including
> >> programming using a single contiguous buffer and a scatter gather table.
> >>
> >> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> >> ---
> >>  drivers/fpga/tests/fpga-mgr-test.c | 311 +++++++++++++++++++++++++++++
> >>  1 file changed, 311 insertions(+)
> >>  create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
> >>
> >> diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
> >> new file mode 100644
> >> index 000000000000..6fd2e235f195
> >> --- /dev/null
> >> +++ b/drivers/fpga/tests/fpga-mgr-test.c
> >> @@ -0,0 +1,311 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * KUnit test for the FPGA Manager
> >> + *
> >> + * Copyright (C) 2023 Red Hat, Inc.
> >> + *
> >> + * Author: Marco Pagani <marpagan@redhat.com>
> >> + */
> >> +
> 
> [...]
> 
> >> +static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
> >> +{
> >> +	struct mgr_stats *stats = mgr->priv;
> >> +	size_t i;
> >> +
> >> +	/* Check the image */
> >> +	stats->image_match = true;
> >> +	for (i = 0; i < count; i++)
> >> +		if (buf[i] != IMAGE_FILL)
> >> +			stats->image_match = false;
> >> +
> >> +	stats->op_write_state = mgr->state;
> >> +	stats->op_write_seq = stats->seq_num++;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int op_write_sg(struct fpga_manager *mgr, struct sg_table *sgt)
> >> +{
> >> +	struct mgr_stats *stats = mgr->priv;
> >> +	struct sg_mapping_iter miter;
> >> +	char *img;
> >> +	size_t i;
> >> +
> >> +	/*
> >> +	 * Check the image, but first skip the header since write_sg will get
> >> +	 * the whole image in sg_table.
> >> +	 */
> >> +	stats->image_match = true;
> >> +	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
> >> +
> >> +	if (!sg_miter_skip(&miter, HEADER_SIZE))
> >> +		stats->image_match = false;
> > 
> > If this fails, should we continue?
> 
> Would it be okay to set the image_match flag to false and then
> return 0 if sg_miter_skip() fails?

That's good to me.

> 
> I think returning an error code to the FPGA manager would not
> be beneficial in this case since if an op fails, it is a failure
> of the FPGA manager itself, not the low-level driver that tests
> the FPGA manager.

So the idea is we never return error code in any fake driver ops?
That's OK. Please add some comments in code for it and the reason.

Thanks,
Yilun

> 
> 
> > 
> >> +
> >> +	while (sg_miter_next(&miter)) {
> >> +		img = miter.addr;
> >> +		for (i = 0; i < miter.length; i++) {
> >> +			if (img[i] != IMAGE_FILL)
> >> +				stats->image_match = false;
> >> +		}
> >> +	}
> >> +
> >> +	sg_miter_stop(&miter);
> >> +
> >> +	stats->op_write_sg_state = mgr->state;
> >> +	stats->op_write_sg_seq = stats->seq_num++;
> >> +
> >> +	return 0;
> >> +}
> > 
> 
