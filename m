Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B640728E52
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Jun 2023 05:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbjFIDKF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Jun 2023 23:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFIDJv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 8 Jun 2023 23:09:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90B630C3;
        Thu,  8 Jun 2023 20:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686280189; x=1717816189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=keYIOK4BlHmkeieE9aGU5Tc1uZ6FNy2R3hKujWVgyk8=;
  b=CZX+exdn5EqLLtZjGF4PV9d5wMO8oD8rBZZoOol6hzJaJjDZLUIuQXGm
   13vI/sTYn9Bp2DhX3xBZM+7z1mVYzgHAFWdkUbFBVc7tXD9vO7w14IZj0
   dN3aXnZ9agvuCr4tr+8Hup426MvpK1kvBys8y5JJpFTSkpfJ7Er/faMR6
   1R3bGPty0kw5xt2r8bpEfzxvrVBhc5cGyS9NpQKD7sFSt72zXXR+vQ268
   ok1hnuOKYRIf33Ky5+JDlXZAcXzgK4N8z0Ghzryu71pt6wW2jc1gLBsxI
   rG99Z8RGQC5FyCIeMaiZlxL1cdjvmJ8k3wLJ5slPmmR3FH2/ld7SWkRW/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="423375779"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="423375779"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 20:09:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="854586872"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="854586872"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jun 2023 20:09:46 -0700
Date:   Fri, 9 Jun 2023 19:09:08 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v6 3/4] fpga: add an initial KUnit suite for the FPGA
 Region
Message-ID: <ZIMIVJtnzjROr88m@yilunxu-OptiPlex-7050>
References: <20230531095405.342080-1-marpagan@redhat.com>
 <20230531095405.342080-4-marpagan@redhat.com>
 <ZHuQc7WfN1zKOeTE@yilunxu-OptiPlex-7050>
 <d1ef2f9a-f416-e7d6-7481-d81c1941702e@redhat.com>
 <ZH8R5APukuZVkIv5@yilunxu-OptiPlex-7050>
 <a9652cb5-3d73-f49f-6de3-a49d528e91ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9652cb5-3d73-f49f-6de3-a49d528e91ec@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-06-07 at 17:57:22 +0200, Marco Pagani wrote:
> 
> 
> On 2023-06-06 13:00, Xu Yilun wrote:
> > On 2023-06-05 at 18:58:56 +0200, Marco Pagani wrote:
> >>
> >>
> >> On 2023-06-03 21:11, Xu Yilun wrote:
> >>> On 2023-05-31 at 11:54:04 +0200, Marco Pagani wrote:
> >>>> The suite tests the programming of an FPGA Region with a Bridge
> >>>> and the function for finding a particular Region.
> >>>>
> >>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> >>>> ---
> >>>>  drivers/fpga/tests/fpga-region-test.c | 186 ++++++++++++++++++++++++++
> >>>>  1 file changed, 186 insertions(+)
> >>>>  create mode 100644 drivers/fpga/tests/fpga-region-test.c
> >>
> >> [...]
> >>
> >>  
> >>> Maybe better just put all tests in one module, and have unified
> >>> fake_mgr_ops/mgr_stats/fake_bridge_ops/bridge_stats across all tests.
> >>>
> >>> In previous thread, I said I'm good to the self-contained test module
> >>> but I didn't actually follow the idea. Sorry for that.
> >>>
> >>> The concern is why in this region test, the write_count and only the
> >>> write_count is taken care of.
> >>>
> >>> Although fpga_mgr_load() test covers all mgr_ops, but does that
> >>> means these ops are still good for more complex case like
> >>> fpga_region_program_fpga()? And there is no guarantee
> >>> fpga_region_program_fpga() would always call mgr_ops the same way
> >>> as fpga_mgr_load() in future.
> >>>
> >>> Similar for fpga_bridge. Maybe a complete setup for fpga_region is
> >>> still necessary.
> >>
> >> I think that putting all tests in a single module (like in previous
> >> versions) goes against the principles of unit testing, making the
> >> code more similar to an integration test.
> >>
> >> Unit tests should be focused on a single behavior. The programming
> >> test case included in the Region's suite should test only the behavior
> >> of the Region itself. Specifically, that fpga_region_program_fpga() calls
> >> get_bridges(), to get and control bridges, and then the Manager for the
> >> actual programming.
> >>
> >> The programming sequence itself is outside the responsibilities of the
> >> Region, and its correctness is already ensured by the Manager suite.
> >> Similarly, the correctness of the Bridge's methods used by the Region
> >> for getting and controlling multiple bridges is already ensured by the
> >> Bridge test suite.
> >>
> >> For this reason, the Manager and Bridge fakes used in the Region suite
> >> implement only the minimal set of operations necessary to ensure the
> >> correctness of the Region's behavior. If I used a "full" Manager (and
> >> tested all mgr_ops), then the test case would have become an integration
> >> test rather than a unit test for the Region.
> > 
> > I agree with you about a unit test should focus on a single behavior. But
> > I have concerns that each test suite uses different definitions of the
> > same structure, mgr/bridge stats, mgr/bridge ops, mgr/bridge ctx. Even
> > if we have full definitions for these structures to acommodate all
> > tests, it doesn't break the principle of unit test, just ignore the fields
> > and skip checks that you don't care. E.g. only checks mgr.write_count &
> > bridge.enable_count for region test.
> > 
> > And a single module simplifies the implementation.
> > 
> > struct mgr_stats {
> > 	...
> > };
> > 
> > struct mgr_ctx {
> > 	struct fpga_image_info *img_info;
> > 	struct fpga_manager *mgr;
> > 	struct platform_device *pdev;
> > 	struct mgr_stats stats;
> > };
> > 
> > struct bridge_stats {
> > 	...
> > };
> > 
> > struct bridge_ctx {
> > 	struct fpga_bridge *bridge;
> > 	struct platform_device *pdev;
> > 	struct bridge_stats stats;
> > };
> > 
> > struct region_ctx {
> > 	struct mgr_ctx mgr_ctx;
> > 	struct bridge_ctx bridge_ctx;
> > 
> > 	struct fpga_region *region;
> > 	struct platform_device *region_pdev;
> > };
> > 
> > How do you think?
> > 
> > Thanks,
> > Yilun
> >
> 
> My concern with unified fakes having the same ops, stats, and context structs
> is that they would couple the test suites together. I think it's better to
> have multiple fakes, each with the single responsibility of providing minimal
> support for the component under test. Otherwise, we would end up having
> overcomplicated fakes that implement the union (in the set theory sense of
> the term) of all behaviors tested by all suites. By using these fakes, some
> test cases might implicitly exercise behaviors that are outside their scope
> (e.g., the Region programming test case calling all Manager ops). I feel
> this would go against the principle of limiting the amount of code under test
> to a single unit. 

OK. On second thought, it is good to me.

I think now the high level opens are all addressed. Will you keep on
improving the patchset or make it stable for upstream? If the later, you
may drop the RFC prefix.

Thanks,
Yilun

> Thanks,
> Marco
> 
> >>> BTW: I like the way that fake drivers are removed. Looks much straight
> >>> forward.
> >>
> >> I appreciate that.
> >>  
> >>> Thanks,
> >>> Yilun
> >>>
> >>
> >> Thanks,
> >> Marco
> >>
> >> [...]
> >>
> > 
> 
