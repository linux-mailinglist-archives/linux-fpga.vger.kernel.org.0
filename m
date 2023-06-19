Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EC37358FB
	for <lists+linux-fpga@lfdr.de>; Mon, 19 Jun 2023 15:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjFSNyv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Jun 2023 09:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjFSNyv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 19 Jun 2023 09:54:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146AABD;
        Mon, 19 Jun 2023 06:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687182890; x=1718718890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C9eEA6raDNp4OEebRrW08vw1n5FIBYIdZcJXkqzQKQE=;
  b=O/OnQw5MSyyymUAN014pZk9HgawvejCudhR2Iib/4YMzGcrK7qnBfTfi
   fMXQr78SVVIY5WzeW3ELDQgcLeBhb4Ghy/rQWiRvID2Cd2++BCoqMCA7S
   0XXlLEdHdWqU1C5BXLmOuqPEHnyYp/OyCptCbOYf/jMzSijB9NttCG9WU
   WG9+kk0UEkNJ3L52cJJxIZzGYnmvbYfiCPrw/iipZV3jVUK0x+1X4cqkl
   m7DxRoO04AyzB2syiNUWze0BCQSnO8PqNSmng0VbDfSGKqABHOaIiKqSM
   vtjFvsCKKdVrhxXJR8MZwNaN/oaa+0rChj7+dL+ktRebdklhSArDx8+Ka
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="423296477"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="423296477"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:54:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="779042764"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="779042764"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jun 2023 06:54:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qBFLA-0050UC-1t;
        Mon, 19 Jun 2023 16:54:44 +0300
Date:   Mon, 19 Jun 2023 16:54:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Peter Colberg <peter.colberg@intel.com>, hao.wu@intel.com,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, aaron.j.grier@intel.com,
        tianfei.zhang@intel.com, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        lgoncalv@redhat.com
Subject: Re: [PATCH] fpga: dfl: afu: use PFN_DOWN() and PFN_PHYS() helper
 macros
Message-ID: <ZJBeJKzEXiu/aHTv@smile.fi.intel.com>
References: <20230616224209.20991-1-peter.colberg@intel.com>
 <2023061916-abacus-dipper-2238@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023061916-abacus-dipper-2238@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 19, 2023 at 03:46:29PM +0200, Greg KH wrote:
> On Fri, Jun 16, 2023 at 06:42:09PM -0400, Peter Colberg wrote:
> > Replace all shifts by PAGE_SHIFT with PFN_DOWN() and PFN_PHYS() helper
> > macros to convert between physical addresses and page frame numbers.
> 
> Is this a bugfix, or just a cleanup?

Cleanup.

-- 
With Best Regards,
Andy Shevchenko


