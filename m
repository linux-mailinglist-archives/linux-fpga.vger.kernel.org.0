Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2206F6AAAAF
	for <lists+linux-fpga@lfdr.de>; Sat,  4 Mar 2023 16:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCDPU6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 4 Mar 2023 10:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDPU5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 4 Mar 2023 10:20:57 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DCB1C33D;
        Sat,  4 Mar 2023 07:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677943257; x=1709479257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w+XSNO3/+gIVMY6jHoCV9uH6n2mtNwZfU8qe3JpSc/o=;
  b=eIalvkqayP2oimWsJiUusCe+18CjzkU3lpfj+W5/DBu4sYyt8VhKoqZo
   BhmQzf+zTO9bKJuwls/3xce7aHKHCLpfd9pmKagl01w7LelbjlZr3ltOK
   Zo9UltL0JaXkKiMhdFPf5/z8gcAjLwRlG/g1zAYC6z8yE2a8QJgatW4Nc
   OArTVQFUxP7JFLNrXNN39bON3Cma8T545Dtkj4FE/TcLc+l1fv5BhLLgw
   R83jkjhaH3JldA8wRhB0bdC3w9hFUNZPMSsm9RwUKHxkT3PKiJLhEmSjO
   c7YKjMkzqumju+p8lni68IvzrCuuSdo9/M4PglBQbgIq81Z3fYu94t+pX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="319093697"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="319093697"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 07:20:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="677997286"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="677997286"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga007.fm.intel.com with ESMTP; 04 Mar 2023 07:20:54 -0800
Date:   Sat, 4 Mar 2023 23:09:46 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] fpga: add initial KUnit test suite
Message-ID: <ZANfOj1MN+HHaF9n@yilunxu-OptiPlex-7050>
References: <20230203170653.414990-1-marpagan@redhat.com>
 <20230203170653.414990-2-marpagan@redhat.com>
 <Y/Chiq2kiAFGZpV6@yilunxu-OptiPlex-7050>
 <8c56c1a2-551d-d3ed-9e32-87ba9b9ea559@redhat.com>
 <Y/hV2F8+ZIcG2Bsq@yilunxu-OptiPlex-7050>
 <7a888be6-db0a-16dd-e0c0-73900ac139ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a888be6-db0a-16dd-e0c0-73900ac139ae@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> >>>> +	ret = init_sgt_bit(&sgt_bit, fake_bit, FAKE_BIT_SIZE);
> >>>> +	KUNIT_ASSERT_EQ(test, ret, 0);
> >>>
> >>> This is not fpga function, do we need the ASSERT?
> >>>
> >>
> >> You're right. I'll change it to EXPECT.
> > 
> > Mm.. I think we may move the sgt initialization in .suite_init, and just
> > return ERROR for failure. Does it help to quickly find out this is an
> > ENV error, not a test case failure?
> 
> I looked through the documentation for guidelines on how to handle
> initialization errors, but found only the eeprom example where KUNIT_ASSERT
> is used to handle errors in eeprom_buffer_test_init(). Existing test suites
> seem to use different approaches to handle initialization errors. Some
> return an error code, while others use KUnit assertions.
> 
> I'm more inclined to follow the example in the documentation and use
> KUnit assertions. Does this approach work for you?

It's good to me.

> 
> 
> After some thought, I'm restructuring the code to test single components
> in isolation before testing them together. In this way, I think the test
> suite will be more in line with the unit testing methodology.
> 
> 
> Thanks,
> Marco
> 
