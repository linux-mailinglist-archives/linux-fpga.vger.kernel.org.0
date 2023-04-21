Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678BA6EA14E
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Apr 2023 03:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjDUBwI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Apr 2023 21:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjDUBwF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Apr 2023 21:52:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE5D6EB5;
        Thu, 20 Apr 2023 18:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682041912; x=1713577912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qOaIZhCM0M7nCC0PwmJL4rbJwQkhe6qCcFlSkgzP2Os=;
  b=RSWBlnD2SngH43rjO9rq0WYogV+r0yij3ASnFjEHs56l3mzaiZlJFSJi
   DwePIYUtXUtGgGHGtnOImF894CtzJDNxCvk1QjR8At3HLsdytcqp1JOHI
   1DVE0OfhcKAam6m9P0ErgOB70+nOR2aTExmYR4AVNbxhPqvwdA8bWb5Xq
   BedIMxnJgJlmsXSwgaT09YzJ3u+j3r+wEfsGq6jXOOcPf5NEMtE0TRkJL
   BwjnmDxgHyqKPROGnfm3AqzQ2heqnGFebnSEun5HGowKyeOGMj3xbhgs3
   3Hdr8hwWBDWihop6pnrvqbH0IBq6W3eJc3fGEolxtSqBQ0X38/By+L1vu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="330092938"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="330092938"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 18:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="836003730"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="836003730"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2023 18:51:49 -0700
Date:   Fri, 21 Apr 2023 17:52:19 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mfd: intel-m10-bmc: Manage access to MAX 10 fw
 handshake registers
Message-ID: <ZEJc06oNSS2ICS1F@yilunxu-OptiPlex-7050>
References: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
 <20230417092653.16487-5-ilpo.jarvinen@linux.intel.com>
 <ZEFjQtOCQCvQJ1k/@yilunxu-OptiPlex-7050>
 <20230420111324.GA970483@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230420111324.GA970483@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-20 at 12:13:24 +0100, Lee Jones wrote:
> On Fri, 21 Apr 2023, Xu Yilun wrote:
> 
> > On 2023-04-17 at 12:26:53 +0300, Ilpo Järvinen wrote:
> > > On some MAX 10 cards, the BMC firmware is not available to service
> > > handshake registers during secure update erase and write phases at
> > > normal speeds. This problem affects at least hwmon driver. When the MAX
> > > 10 hwmon driver tries to read the sensor values during a secure update,
> > > the reads are slowed down (e.g., reading all D5005 sensors takes ~24s
> > > which is magnitudes worse than the normal <0.02s).
> > > 
> > > Manage access to the handshake registers using a rw semaphore and a FW
> > > state variable to prevent accesses during those secure update phases
> > > and return -EBUSY instead.
> > > 
> > > If handshake_sys_reg_nranges == 0, don't update bwcfw_state as it is not
> > > used. This avoids the locking cost.
> > > 
> > > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > Co-developed-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> > 
> > Hi Lee:
> > 
> > Could the fpga part also been applied to mfd tree when everyone is good?
> 
> Yes, with an Acked-by it can.

Acked-by: Xu Yilun <yilun.xu@intel.com>

> 
> -- 
> Lee Jones [李琼斯]
