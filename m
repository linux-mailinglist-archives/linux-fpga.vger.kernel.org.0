Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D355D1CE
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Jun 2022 15:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiF0JBO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Jun 2022 05:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiF0JBN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 27 Jun 2022 05:01:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB09638D;
        Mon, 27 Jun 2022 02:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656320472; x=1687856472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q8IKnNQM5WuT51cs8F0X37bF3np5AyCm5DrvLRqHPNg=;
  b=LdxQKtLM2RVNvp9ogJ6K1DVwD3EZ2BZ8bkFPpAgbRyRN9mo3Bc7L0X4w
   1HyHSzhjJlCMxjhF+8qMpw5Y6E4jjC/exHKwHSPKqWtKTieeBpHlxyRkO
   BJWMZd6goQc1b1w75sNGKoCyBqtORfVz6iZYpbzlJVK7BcVfLQsem3fTQ
   h5dg5gmvrxIK88+m6MtuV4zAUSnU0CWN1I1Qm7fFx0pieI/A18/1P7kSx
   wZD+w0fCMIPFJ5Ejfjbpm2Y+ni9+H3PkDipzDuFBE1AKcr9/dX0N+PBcZ
   pPTrT6SUwzdwugpulGVvo50ha6asbKEyfnqLam6vjBi5UHUXlnMTAq2YC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="281442844"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="281442844"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 02:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="679498814"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jun 2022 02:01:09 -0700
Date:   Mon, 27 Jun 2022 16:52:55 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     tien.sung.ang@intel.com
Cc:     christophe.jaillet@wanadoo.fr, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, trix@redhat.com
Subject: Re: [PATCH v2] fpga: altera-cvp: Truncated bitstream error support
Message-ID: <20220627085255.GA2264502@yilunxu-OptiPlex-7050>
References: <20220608103058.GG481269@yilunxu-OptiPlex-7050>
 <20220627074553.3136597-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627074553.3136597-1-tien.sung.ang@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 27, 2022 at 03:45:53PM +0800, tien.sung.ang@intel.com wrote:
> > > Though without doubt, your solution is doable, I have a 
> > > discussion with the Intel architect and they insisted that
> > > the device driver must not make such a decision. The decision to 
> > > drop or accept a transfer is up to the firmware. The firmware
> 
> > Why dropping or accepting is forbidden, but padding is allowed? If the
> > decision is no operation to the data, then padding should also be
> > forbidden.
> 
> > > insisted that the buffer be padded with whatever value. They
> 
> > If I understand right, the 2 decisions are conflicted. On one hand,
> > the driver should not care about the data. On another hand, the
> > driver should still care about the data for some rule.
> 
> > So please firstly reach your agreement before making patches.
> 
> Had some delays in replying,from the perspective of the driver, 
> Intel architects want it to be just purely on the transfer of 
> data without inspecting the data. 
> If the size of a transfer is 4096bytes, we can padd it. 
> I can do that which I think it is not an issue.
> Let me create a reworked patch to pad the payload with Zeros.

No, it's not about padding with Zeros or other values. If we should
stick on no image touching, then please fix the firmware. If we need
a workaround in driver, then making a decent fix. Blindly copy the image
is just a bad idea, and it could actually be avoided.

Thanks,
Yilun

> Would this be OK for patch v3?
> 
> > > Yes, it could look confusing to other programmers. And, yes, the 
> > > padding doesn't matter. Let me relook into this. As the driver is 
> > > already re-tested by the silicon validatioin. 
> > > I want to avoid making any change as it
> > > would meant another couple of weeks of re-testing. 
> > > Can this be accepted as it is?
> 
> > Sorry, I can't. Some clarification is needed.
> 
> Reply as above, let us implement the padding in the
> next patch v3. Appreciate your inputs. Thanks
