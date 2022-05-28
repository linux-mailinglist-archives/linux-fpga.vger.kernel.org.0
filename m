Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EDF536C43
	for <lists+linux-fpga@lfdr.de>; Sat, 28 May 2022 12:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351167AbiE1KJ1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 May 2022 06:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351073AbiE1KJ0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 28 May 2022 06:09:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3E1FF3;
        Sat, 28 May 2022 03:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653732565; x=1685268565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ssEQf9Dr8zA9ORwC07rfd2cEchsyeE8yAERhKLbsJHU=;
  b=jmb7ztuZ4MWj6wo/xYTt72IqiCOETRrGWrrTGfrz644LwF9NnbWLhOhj
   Pb9vopepUUpP31DpO2HtG3UK7pG/o4qkAAO/ohetdM84TA6uiw5RZc3ly
   EpR+pKL3QAO9ViELEH+3F4FJA2lKJjD7iPdZtrPtewSY0PeOkegsYLHBD
   +Fe9Z/RqsCyokFzWrXJAkyTwkiGFZof47TZEKEds2TyGf4KdwJ+mPEplr
   1WbQbL9yi0u7zs+8+kfUmdLoCXTKpIVxryERIkIGKiNvI63o97wmzwn/8
   Kd1GN5Gh6PjtyKa1AwoRpINfs8YAk2KZV5ThDr3XVzWf7F29O/a0UJnin
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="256728597"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="256728597"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 03:09:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="719230050"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga001.fm.intel.com with ESMTP; 28 May 2022 03:09:23 -0700
Date:   Sat, 28 May 2022 18:01:40 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     tien.sung.ang@intel.com
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-cvp: Truncated bitstream error support
Message-ID: <20220528100140.GC175008@yilunxu-OptiPlex-7050>
References: <3911c8c7-da6d-e6f2-c747-3b601d9cdacc@redhat.com>
 <20220519043412.2805706-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519043412.2805706-1-tien.sung.ang@intel.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 19, 2022 at 12:34:12PM +0800, tien.sung.ang@intel.com wrote:
> The send_buf is always used throughout the life-span of the CvP driver.
> Hence, we thought it would be wise to just pre-allocate it one time
> at the start of the probe/init.
> It is also fine if we do it in the altera_cvp_write. The only issue we
> see in this is that, a minor hit on the performance as you need to 
> then, allocate the buffer on every new CvP FPGA configuration write.
> 
> As for STEP 16, the previous implementation checks the Error latch bit
> which stores the previous transaction's result. If an error occurs
> prior to this, the driver would throw an error which is not right.
> The correct step is to just check for the current CvP error status 
> from the register.
> Hope that is fine with you. Thanks

Please comment inline in the mail, like others do.

Thanks,
Yilun
