Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D725723595
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Jun 2023 05:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjFFDBe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Jun 2023 23:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjFFDBc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Jun 2023 23:01:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF83312D;
        Mon,  5 Jun 2023 20:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686020488; x=1717556488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P+ZEvriustMbFcwF6+B7XqFEaeqMxamVNmjqUFdX8LY=;
  b=n1KloCo77n0lDfOCsctQ4OZ3ZLrQW4RL4Thvq+FrhtyCNYT45GvxJW3/
   2w6YVSQhKkazcDdUKbpjYpiEYCwcvOC/U+7NxUOc5j0mu8nRejVy+2d1S
   ZDhzqlJ3jUCsol/c3gEdk3iFhpL1C89EO546az+q+RNK9LqBliNi5TXCl
   mTudqRlFZ96PpKcqJvuwlJinTUvG+GlA7hv9ydbu7xbde0Qvq3zH8uoDy
   KBFdgZI8mM1aHnWTUltHkfJkn9BoYQ21g7i5bQlBfnMz5tZXxe7C4CDUj
   72YAgVn4FUILzMdDYliCUctJuD+O/2cePUfOHwgUxARB4TaA9UdKvHN/9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="420094285"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="420094285"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 20:01:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="883161344"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="883161344"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 05 Jun 2023 20:01:26 -0700
Date:   Tue, 6 Jun 2023 19:00:52 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v6 3/4] fpga: add an initial KUnit suite for the FPGA
 Region
Message-ID: <ZH8R5APukuZVkIv5@yilunxu-OptiPlex-7050>
References: <20230531095405.342080-1-marpagan@redhat.com>
 <20230531095405.342080-4-marpagan@redhat.com>
 <ZHuQc7WfN1zKOeTE@yilunxu-OptiPlex-7050>
 <d1ef2f9a-f416-e7d6-7481-d81c1941702e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1ef2f9a-f416-e7d6-7481-d81c1941702e@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-06-05 at 18:58:56 +0200, Marco Pagani wrote:
> 
> 
> On 2023-06-03 21:11, Xu Yilun wrote:
> > On 2023-05-31 at 11:54:04 +0200, Marco Pagani wrote:
> >> The suite tests the programming of an FPGA Region with a Bridge
> >> and the function for finding a particular Region.
> >>
> >> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> >> ---
> >>  drivers/fpga/tests/fpga-region-test.c | 186 ++++++++++++++++++++++++++
> >>  1 file changed, 186 insertions(+)
> >>  create mode 100644 drivers/fpga/tests/fpga-region-test.c
> 
> [...]
> 
>  
> > Maybe better just put all tests in one module, and have unified
> > fake_mgr_ops/mgr_stats/fake_bridge_ops/bridge_stats across all tests.
> > 
> > In previous thread, I said I'm good to the self-contained test module
> > but I didn't actually follow the idea. Sorry for that.
> > 
> > The concern is why in this region test, the write_count and only the
> > write_count is taken care of.
> > 
> > Although fpga_mgr_load() test covers all mgr_ops, but does that
> > means these ops are still good for more complex case like
> > fpga_region_program_fpga()? And there is no guarantee
> > fpga_region_program_fpga() would always call mgr_ops the same way
> > as fpga_mgr_load() in future.
> > 
> > Similar for fpga_bridge. Maybe a complete setup for fpga_region is
> > still necessary.
> 
> I think that putting all tests in a single module (like in previous
> versions) goes against the principles of unit testing, making the
> code more similar to an integration test.
> 
> Unit tests should be focused on a single behavior. The programming
> test case included in the Region's suite should test only the behavior
> of the Region itself. Specifically, that fpga_region_program_fpga() calls
> get_bridges(), to get and control bridges, and then the Manager for the
> actual programming.
> 
> The programming sequence itself is outside the responsibilities of the
> Region, and its correctness is already ensured by the Manager suite.
> Similarly, the correctness of the Bridge's methods used by the Region
> for getting and controlling multiple bridges is already ensured by the
> Bridge test suite.
> 
> For this reason, the Manager and Bridge fakes used in the Region suite
> implement only the minimal set of operations necessary to ensure the
> correctness of the Region's behavior. If I used a "full" Manager (and
> tested all mgr_ops), then the test case would have become an integration
> test rather than a unit test for the Region.

I agree with you about a unit test should focus on a single behavior. But
I have concerns that each test suite uses different definitions of the
same structure, mgr/bridge stats, mgr/bridge ops, mgr/bridge ctx. Even
if we have full definitions for these structures to acommodate all
tests, it doesn't break the principle of unit test, just ignore the fields
and skip checks that you don't care. E.g. only checks mgr.write_count &
bridge.enable_count for region test.

And a single module simplifies the implementation.

struct mgr_stats {
	...
};

struct mgr_ctx {
	struct fpga_image_info *img_info;
	struct fpga_manager *mgr;
	struct platform_device *pdev;
	struct mgr_stats stats;
};

struct bridge_stats {
	...
};

struct bridge_ctx {
	struct fpga_bridge *bridge;
	struct platform_device *pdev;
	struct bridge_stats stats;
};

struct region_ctx {
	struct mgr_ctx mgr_ctx;
	struct bridge_ctx bridge_ctx;

	struct fpga_region *region;
	struct platform_device *region_pdev;
};

How do you think?

Thanks,
Yilun

> > BTW: I like the way that fake drivers are removed. Looks much straight
> > forward.
> 
> I appreciate that.
>  
> > Thanks,
> > Yilun
> >
> 
> Thanks,
> Marco
> 
> [...]
> 
