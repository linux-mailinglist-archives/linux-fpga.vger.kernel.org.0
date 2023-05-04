Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D1C6F6406
	for <lists+linux-fpga@lfdr.de>; Thu,  4 May 2023 06:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjEDEZY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 May 2023 00:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEDEZX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 4 May 2023 00:25:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3C8E7;
        Wed,  3 May 2023 21:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683174322; x=1714710322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dya1D6Mnv6a/Xw9LvYK+h+ly8LrufF6GuEJbEAmnId8=;
  b=e/1PKwiAEgBcjQp98h3dt5xsRSzzDVA+bF5Ew9ezNFWUgIg2gSICaJli
   yo2XIH9jjLYrbnqbdXnFcv1WLekIT6476A3pjmt53LCw3cVfrfk5DZLDq
   x0yXhptpmxLUwPOGDQ15zf6dTELf+00n90h97lwMuZmR/1p0GEj74KfKs
   4cfQ7Pih49gvbCdHHZ35+eQbEM1poy9siA382i6xQeG4DU5vCXdwa4H23
   K9mQslzi4PGrG00k+63sFASksgYAMk3eiitxEJP/wb3DdPgQjJz6ah4CT
   Q0DzkEiZJldWG/DsooS60PH0//Gj6Gqhu+mscBbNg/w9fkP19HTuL7Iem
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="348873838"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="348873838"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 21:25:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="943170223"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="943170223"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 03 May 2023 21:25:20 -0700
Date:   Thu, 4 May 2023 20:25:32 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/4] fpga: add fake FPGA manager
Message-ID: <ZFOkPNOmbjsalTmn@yilunxu-OptiPlex-7050>
References: <20230417122308.131453-1-marpagan@redhat.com>
 <20230417122308.131453-2-marpagan@redhat.com>
 <ZEGE+UqTyKGTyv9h@yilunxu-OptiPlex-7050>
 <cef792a1-42c1-b262-b07e-529006fdcb6d@redhat.com>
 <594789b2-eb5d-11fc-9c47-310bdb258f7c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <594789b2-eb5d-11fc-9c47-310bdb258f7c@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-05-03 at 18:53:02 +0200, Marco Pagani wrote:
> On 2023-04-26 17:44, Marco Pagani wrote:
> > 
> > 
> > On 2023-04-20 20:31, Xu Yilun wrote:
> >> On 2023-04-17 at 14:23:05 +0200, Marco Pagani wrote:
> >>> Add fake FPGA manager platform driver with support functions.
> >>> The driver checks the programming sequence using KUnit expectations.
> >>> This module is part of the KUnit tests for the FPGA subsystem.
> >>>
> >>> Signed-off-by: Marco Pagani <marpagan@redhat.com>

[...]

> >>> +EXPORT_SYMBOL_GPL(fake_fpga_mgr_check_write_sgt);
> >>
> >> I'm wondering, if we could move all these exported functions out of
> >> fake_fpga driver module. And make this driver module serves FPGA
> >> mgr framework only, just like other fpga drivers do.
> >>
> >> I assume the main requirement is to check the statistics produced
> >> by the fake fpga driver. Directly accessing mgr->priv outside the
> >> driver could be unwanted.  To solve this, could we create a shared
> >> buffer for the statistics and pass to fake drivers by platform data.
> >>
> >> I hope move all the tester's actions in fpga-test.c, so that people
> >> could easily see from code what a user need to do to enable fpga
> >> reprogramming and what are expected in one file. The fake drivers could
> >> be kept as simple, they only move the process forward and produce
> >> statistics.
> >>
> >> Thanks,
> >> Yilun
> >>
> > 
> > I agree with you. Initially, I wanted to keep all KUnit test assertions
> > and expectations contained in fpga-test. However, I could not find a simple
> > way to test that the FPGA manager performs the correct state transitions
> > during programming. So I ended up putting KUnit assertions in the methods
> > of the low-level fake driver as a first solution.
> > 
> > I like your suggestion of using a shared buffer to have a cleaner
> > implementation. My only concern is that it would make the code more complex.
> > I will work on this for V5.
> > 
> 
> I experimented with a couple of alternatives to move all tests inside
> fpga-test and remove the external functions. Unfortunately, each alternative
> comes with its drawbacks.
> 
> Using a shared buffer (e.g., kfifo) to implement an events buffer between
> fake mgr/bridge and the fpga-test overcomplicates the code (i.e., defining
> message structs, enums for the operations, locks, etc.).

Oh, I actually didn't expect a message based mechanism for statistics
reading, which is overcomplicated for a test.

Maybe just pass a structured data buffer via platform_data, so that both
fpga-test & fake drivers could recognize and access it directly. fpga-test
could directly check the updated statistics after reprograming and assert
them. Is that OK for you?

Thanks,
Yilun

> 
> Moving fake modules' (mgr, bridge, region) implementations inside fpga-test
> makes fpga-test monolithic and harder to understand and maintain.
> 
> Accessing modules' private data directly from fpga-test breaks encapsulation.
> 
> Overall, it seems to me that using external functions to get the state of fake
> modules is the least-worst alternative. What are your thoughts and preferences?
> 
> Thanks,
> Marco
> 
> 
> >>> [...]
> 
