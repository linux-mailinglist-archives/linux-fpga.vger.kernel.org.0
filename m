Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430C6663E12
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Jan 2023 11:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjAJKW5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Jan 2023 05:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjAJKWe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 10 Jan 2023 05:22:34 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0AD5AC55;
        Tue, 10 Jan 2023 02:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673346104; x=1704882104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PkKqqmBLchSYZl+hz18MXJzVs0JIqEvfTbNCyQox3Kg=;
  b=l4HmJekwWMewq0ZaT40iKFit+vY69pAYZGQUfo76PO0kBnsdAevlGBB3
   iuK/xwp0rqnvleewzfGuX5eY3/KvR63An3HH1o5QseCY3CZM/NEXfsAan
   pYZ4ICv273K7o1aUk0nDpXazU8U5T/U4SF9bB1Y3hmW4KM2//sSSDmq2h
   NxotBgCkKS17VF/WnApKL2OnayQ+hP/b943auGlcNFQPRODlF6vYOX7zl
   1Mtv0OwiBk9UsfIbxJc8xS1U/6DGhdyscPtm2jcKSRJK3bemBKFIbKAta
   DveKSMaxBVKd08KmTF4+g8JLxINE3MD0RFPb7mn6SxzGXrGXowp2ZuntN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="306625517"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="306625517"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 02:21:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="658937444"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="658937444"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2023 02:21:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pFBlA-006yvn-04;
        Tue, 10 Jan 2023 12:21:36 +0200
Date:   Tue, 10 Jan 2023 12:21:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v10 3/4] fpga: dfl: add basic support for DFHv1
Message-ID: <Y708L2rRc1RDVkui@smile.fi.intel.com>
References: <20230110003029.806022-1-matthew.gerlach@linux.intel.com>
 <20230110003029.806022-4-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110003029.806022-4-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 09, 2023 at 04:30:28PM -0800, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Version 1 of the Device Feature Header (DFH) definition adds
> functionality to the Device Feature List (DFL) bus.
> 
> A DFHv1 header may have one or more parameter blocks that
> further describes the HW to SW. Add support to the DFL bus
> to parse the MSI-X parameter.
> 
> The location of a feature's register set is explicitly
> described in DFHv1 and can be relative to the base of the DFHv1
> or an absolute address. Parse the location and pass the information
> to DFL driver.

...

> v10: change dfh_find_param to return size of parameter data in bytes

The problem that might occur with this approach is byte ordering.
When we have u64 items, we know that they all are placed in CPU
ordering by the bottom layer. What's the contract now? Can it be
a problematic? Please double check this (always keep in mind BE32
as most interesting case for u64/unsigned long representation and
other possible byte ordering outcomes).

-- 
With Best Regards,
Andy Shevchenko


