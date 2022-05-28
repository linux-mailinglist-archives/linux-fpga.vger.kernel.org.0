Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75C6536BBF
	for <lists+linux-fpga@lfdr.de>; Sat, 28 May 2022 11:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiE1JFq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 May 2022 05:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiE1JFo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 28 May 2022 05:05:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8579314;
        Sat, 28 May 2022 02:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653728743; x=1685264743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZX3WQewXz4ZS0BrMZQpFM75liWHbc1CEUyhcETyK11E=;
  b=U4CuUcSDRwTPx9jf6CrK28FmVvM5Ppq/rGlkNQB3f9SQXUZVUlnfcy/B
   JFz4aVvjLUvy8tG7LYVH4mMFNhh0b7Qy7N0glCDv6VuRF4x92EQJV2tCW
   n5a3SL8K0GRff2VNMoqTevaKKNGBeojqIffrQBLW/cVhOHIRjQll7BXmy
   Go6qD6IN7MUl0Ime1gxEf8PcV9w/HbkGPkaQp8/xaDYwhYn3O7nvI3FCE
   2jWcu9xm4nLAKw3PNPtFMietGQ6BAfAFX26dbL64w/hO+eKkz9TlZlAK2
   rEhLIjR7GGW0KBn5nuyneDJyqiCVDyLtqblBZjk95fRf/SXmEAAubzIJL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="272220588"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="272220588"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 02:05:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="604312684"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 28 May 2022 02:05:41 -0700
Date:   Sat, 28 May 2022 16:57:57 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     adrian.ho.yin.ng@intel.com
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] fpga: fpga-mgr: Add support for DebugFS for FPGA
 Manager Framework
Message-ID: <20220528085757.GA175008@yilunxu-OptiPlex-7050>
References: <20220517084108.1516-1-adrian.ho.yin.ng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517084108.1516-1-adrian.ho.yin.ng@intel.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, May 17, 2022 at 04:41:08PM +0800, adrian.ho.yin.ng@intel.com wrote:
> From: Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>
> 
> Hi,
> 
> A DebugFS for the FPGA Manager Framework is implemented which supports 
> read/write functionality for the FPGA image firmware file to program for 
> debugging purposes. To facilitate in usage a documentation for debugFS is 
> added. A debugFS interface is extended for setting the maximum time in 
> microseconds for the FPGA to go to the operating state after the region 
> has been programmed.

There were some discussion about the FPGA reprograming user interface in
resent years. For FPGA framework, a well designed user interface is
needed rather than a debug one. As is stated by the Patch #2, the FPGA
reprograming should take care of the running devices on that FPGA
region, or system breaks.

Thanks
Yilun

> 
> Adrian Ng Ho Yin (1):
>   fpga: Implement DebugFS for FPGA Manager Framework
> 
> Alan Tull (1):
>   fpga: doc: documentation for FPGA debugfs
> 
> Matthew Gerlach (1):
>   add debugfs interface for fpga config complete timeout
> 
>  Documentation/fpga/debugfs.txt  |  39 +++++++
>  drivers/fpga/Kconfig            |   7 ++
>  drivers/fpga/Makefile           |   1 +
>  drivers/fpga/fpga-mgr-debugfs.c | 188 ++++++++++++++++++++++++++++++++
>  drivers/fpga/fpga-mgr-debugfs.h |  32 ++++++
>  drivers/fpga/fpga-mgr.c         |   8 ++
>  include/linux/fpga/fpga-mgr.h   |   3 +
>  7 files changed, 278 insertions(+)
>  create mode 100644 Documentation/fpga/debugfs.txt
>  create mode 100644 drivers/fpga/fpga-mgr-debugfs.c
>  create mode 100644 drivers/fpga/fpga-mgr-debugfs.h
> 
> -- 
> 2.26.2
