Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F22C705CCF
	for <lists+linux-fpga@lfdr.de>; Wed, 17 May 2023 04:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjEQCEz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 May 2023 22:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjEQCEw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 16 May 2023 22:04:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB9C4231;
        Tue, 16 May 2023 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684289083; x=1715825083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GTa7OUv1VgGYQN8Q1QosotkMM+pqLAdlleu4ehfda+o=;
  b=TJ58sRZCo+rYCiQO2bOX6smJd6cqeq6MYSG+z6m2z2MvZ+SlKjAAm/V6
   gktG/MSOyKWAeOLpiZPsWxiY4R1ULrYSYdIWi2WRUL2yMVkcdZFIYYdxM
   1w1Nn/rOjKzriwTQsKIwFHunbYvzC9NbrLw6MehGUqmmXvh1tNwniyRYB
   5/kPdAPblcVyHPlwd/o8rUQoswj7b5qyIXaLMlWxHNtlduZJ/d0kg86+f
   IQe62CjQbrVgjyMjOJ5Cr2rK1ohqRqCzZ1BP1HI9gqnzjliMvvRGcmjAP
   nhxvmK9ZQRN+0wB+txCFYHgkgfLnrAhWsHIQyRm2fVhejlPG6DATq1Gkf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="331256269"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="331256269"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 19:04:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="948079086"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="948079086"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 16 May 2023 19:04:41 -0700
Date:   Wed, 17 May 2023 18:04:36 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v5 4/4] fpga: add initial KUnit test suites
Message-ID: <ZGSmtCkPwi2TMW7K@yilunxu-OptiPlex-7050>
References: <20230511141922.437328-1-marpagan@redhat.com>
 <20230511141922.437328-5-marpagan@redhat.com>
 <ZF/LpdlyBu2Z1uQE@yilunxu-OptiPlex-7050>
 <a50022a6-59e1-6b53-2c5b-c6eb44277876@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a50022a6-59e1-6b53-2c5b-c6eb44277876@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-05-15 at 19:24:07 +0200, Marco Pagani wrote:
> 
> 
> On 2023-05-13 19:40, Xu Yilun wrote:
> > On 2023-05-11 at 16:19:22 +0200, Marco Pagani wrote:
> >> Introduce initial KUnit tests for the FPGA subsystem. Tests are organized
> >> into three test suites. The first suite tests the FPGA Manager.
> >> The second suite tests the FPGA Bridge. Finally, the last test suite
> >> models a complete FPGA platform and tests static and partial reconfiguration.
> >>
> >> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> 
> [...]
> 
> >> +static void fpga_bridge_test_get_put_list(struct kunit *test)
> >> +{
> >> +	struct list_head bridge_list;
> >> +	struct fake_fpga_bridge *bridge_0_ctx, *bridge_1_ctx;
> >> +	int ret;
> >> +
> >> +	bridge_0_ctx = test->priv;
> >> +
> >> +	/* Register another bridge for this test */
> >> +	bridge_1_ctx = fake_fpga_bridge_register(test, NULL);
> >> +	KUNIT_ASSERT_FALSE(test, IS_ERR(bridge_1_ctx));
> > 
> > I think bridge_1 could also be initialized in test_init together with
> > bridge_0
> 
> I can do it, but it would remain unused in the previous test case.
>  
> >> +
> >> +	INIT_LIST_HEAD(&bridge_list);
> >> +
> >> +	/* Get bridge_0 and add it to the list */
> >> +	ret = fpga_bridge_get_to_list(bridge_1_ctx->bridge->dev.parent, NULL,
> >> +				      &bridge_list);
> >> +	KUNIT_EXPECT_EQ(test, ret, 0);
> >> +
> >> +	KUNIT_EXPECT_PTR_EQ(test, bridge_1_ctx->bridge,
> >> +			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
> > 
> > Should operate on bridge_0_ctx?
> 
> Yes, sorry. Code and comments are reversed. I'll fix it in the next version.
> 
> >> +
> >> +	/* Get bridge_1 and add it to the list */
> >> +	ret = fpga_bridge_get_to_list(bridge_0_ctx->bridge->dev.parent, NULL,
> >> +				      &bridge_list);
> >> +	KUNIT_EXPECT_EQ(test, ret, 0);
> >> +
> >> +	KUNIT_EXPECT_PTR_EQ(test, bridge_0_ctx->bridge,
> >> +			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
> > 
> > Should operate on bridge_1_ctx?
> 
> Same.
> 
> >> +
> >> +	/* Disable an then enable both bridges from the list */
> >> +	KUNIT_EXPECT_TRUE(test, bridge_0_ctx->stats.enable);
> > 
> > Why expect enable without fpga_bridges_enable()?
> 
> To check that the bridge is initialized in the correct (enabled) state.
> 
> [...]
> 
> >> +static void fpga_test_partial_rcfg(struct kunit *test)
> >> +{
> >> +	struct fpga_base_ctx *base_ctx;
> >> +	struct fake_fpga_region *sub_region_0_ctx, *sub_region_1_ctx;
> >> +	struct fake_fpga_bridge *sub_bridge_0_ctx, *sub_bridge_1_ctx;
> >> +	struct fpga_image_info *partial_img_info;
> >> +	int ret;
> >> +
> >> +	base_ctx = test->priv;
> >> +
> >> +	/*
> >> +	 * Add two reconfigurable sub-regions, each controlled by a bridge. The
> >> +	 * reconfigurable sub-region are children of their bridges which are,
> >> +	 * in turn, children of the base region. For simplicity, the same image
> >> +	 * is used to configure reconfigurable regions
> >> +	 */
> >> +	sub_bridge_0_ctx = fake_fpga_bridge_register(test,
> >> +						     &base_ctx->region_ctx->region->dev);
> >> +	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_bridge_0_ctx));
> >> +
> >> +	sub_region_0_ctx = fake_fpga_region_register(test, base_ctx->mgr_ctx->mgr,
> >> +						     &sub_bridge_0_ctx->bridge->dev);
> >> +	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_region_0_ctx));
> >> +
> >> +	ret = fake_fpga_region_add_bridge(sub_region_0_ctx, sub_bridge_0_ctx->bridge);
> >> +	KUNIT_ASSERT_EQ(test, ret, 0);
> >> +
> >> +	sub_bridge_1_ctx = fake_fpga_bridge_register(test,
> >> +						     &base_ctx->region_ctx->region->dev);
> >> +	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_bridge_1_ctx));
> >> +
> >> +	sub_region_1_ctx = fake_fpga_region_register(test, base_ctx->mgr_ctx->mgr,
> >> +						     &sub_bridge_1_ctx->bridge->dev);
> >> +	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_region_1_ctx));
> >> +
> >> +	ret = fake_fpga_region_add_bridge(sub_region_1_ctx, sub_bridge_1_ctx->bridge);
> >> +	KUNIT_ASSERT_EQ(test, ret, 0);
> > 
> > I'm wondering if we need to construct the topology for partial
> > reconfiguration test. The FPGA core doesn't actually check the topology.
> > It is OK to do partial reconfiguration for a region without parents as
> > long as its associated FPGA manager device has the capability.
> > 
> > Thanks,
> > Yilun
> 
> I agree with you. Creating a hierarchical layout is rather unnecessary.
>

I assume the following sections have nothing to do with hierarchial
layout, is it?
 
> Initially, the idea was to test that all components behave as expected
> in a complete setup, e.g., only the bridge of the specific reconfigurable
> region gets disabled during programming and then re-enabled.
> 
> However, after some iterations, I'm starting to think that it would be
> better to restructure the whole test code into a set of self-contained
> test modules, one for each core component. 
> 
> In that way, each module would contain the implementation of the fake/mock
> low-level driver and the related tests. For instance, the manager module
> would contain the implementation of the fake manager and the test_img_load_buf
> and test_img_load_sgt test cases. Similarly, the bridge module would contain
> the fake/mock bridge implementation and the test_toggle and test_get_put_list
> cases.
> 
> I think that in this way, the code would be simpler and more adherent to the
> unit testing methodology. The downside is that making tests that need multiple
> components would be more cumbersome and possibly lead to code duplication.
> For instance, testing the region's fpga_region_program_fpga() would require
> implementing additional local mock/fakes for the manager and bridge.

This way is good to me.

> 
> What do you think?
> 
> Thanks,
> Marco
> 
> [...]
> 
