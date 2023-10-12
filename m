Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178DF7C645B
	for <lists+linux-fpga@lfdr.de>; Thu, 12 Oct 2023 07:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbjJLFGe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 12 Oct 2023 01:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjJLFGd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 12 Oct 2023 01:06:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79B190
        for <linux-fpga@vger.kernel.org>; Wed, 11 Oct 2023 22:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697087192; x=1728623192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WO8Xl915wLLMKD54gUXouSYJ8si38jCrpFqoVj9o+Io=;
  b=fu+kMxbt07TG1zCS1HSg362WMET6W8c088Oe7vRXbrKuc9rqNKCGxOpD
   UD3UgNYt25GRhaKBrLAZg19B2bYChmmA0BDqs1p2Wg9fppW76dboBeZkU
   PLBw+w6z4panTJn9vvUPIpCs7gVBSt8Ut/9vdHHsK2kVPUiMNfRt3huDx
   6XcKtF/1gQa1D1wzBfh7gYQdvcQPa0MAD27ntr4wQK6gTxb59y4bsS6e+
   7tqVEvNCvDWccuvx5aoTag0yoKTxCUYSsXbfnJY1SDsXgbp8cfYSI6Ykx
   lsRxbYLndggZqGR7l7l8V5sGeha9OcUfRoM0tWnHlVmrjg9f1WYblihVZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415882692"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="415882692"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 22:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="747738579"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="747738579"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga007.jf.intel.com with ESMTP; 11 Oct 2023 22:06:29 -0700
Date:   Thu, 12 Oct 2023 13:05:34 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Jinjie Ruan <ruanjinjie@huawei.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: Fix memory leak for fpga_region_test_class_find()
Message-ID: <ZSd+npcx0KZuYUjP@yilunxu-OptiPlex-7050>
References: <20231007094321.3447084-1-ruanjinjie@huawei.com>
 <d14b4c86-8d6b-a9b3-c81a-34f07301cf96@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d14b4c86-8d6b-a9b3-c81a-34f07301cf96@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Oct 09, 2023 at 02:03:18PM +0200, Marco Pagani wrote:
> 
> 
> On 2023-10-07 11:43, Jinjie Ruan wrote:
> > When CONFIG_FPGA_KUNIT_TESTS=m and making CONFIG_DEBUG_KMEMLEAK=y
> > and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, modprobe fpga-region-test and then
> > rmmod fpga-region-test, the below memory leak is detected.
> > 
> > fpga_region_class_find() in fpga_region_test_class_find() will call
> > get_device() if the data is matched, which will increment refcount for
> > dev->kobj, so it should call put_device() to decrement refcount for
> > dev->kobj to free the region, because fpga_region_unregister() will call
> > fpga_region_dev_release() only when the refcount for dev->kobj is zero
> > but fpga_region_test_init() call device_register() in
> > fpga_region_register_full(), which also increment refcount.
> > 
> > So call put_device() after calling fpga_region_class_find() in
> > fpga_region_test_class_find(). After applying this patch, the following
> 
> Looks good to me. Thanks.
> 
> Reviewed-by: Marco Pagani <marpagan@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.
