Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B709536CC5
	for <lists+linux-fpga@lfdr.de>; Sat, 28 May 2022 14:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiE1MMu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 May 2022 08:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiE1MMt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 28 May 2022 08:12:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0451CFFA;
        Sat, 28 May 2022 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653739968; x=1685275968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NZkH5yC96HiWlzsDjnYwGEjVnotLgpV0mtwsk3uj0n4=;
  b=L5id6vwKBZOvhRhj+VWHJJT8Zqq6YQWEc+Z1U0SmXjpJb2aoa+VBKAIt
   p/lj0iT3b4VKPLu4hUFm+cZfrFMYX7vBKPSkIVVd2FXcRlD/POyvNqJYG
   S1G9dvDTBFDM7utaWWdSyCjfbBrloG7s5YLzCO5ltvJRnpcuwzN3FHo0C
   E0139ri8B3X+BQOquUN4bUCQjBsubqJ9tN3FKtzdqPhBGewqb1tyVSlvI
   K3b9CFusD9y3vb4+YOyJSU5T4/G0kJ9R6U9veKdIawrr0J7UmdC1giuPW
   2pEr8w5B2HLGUa2i4kRNjD3yhjm/FNq2ohxYqJJBIppMTlquU9M8i6tr2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="255158072"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="255158072"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 05:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="719251537"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga001.fm.intel.com with ESMTP; 28 May 2022 05:12:47 -0700
Date:   Sat, 28 May 2022 20:05:03 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     tien.sung.ang@intel.com
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-cvp: Truncated bitstream error support
Message-ID: <20220528120503.GB175058@yilunxu-OptiPlex-7050>
References: <b0fd6c41-f8a4-bb3a-d05a-2ea17d4ffc80@redhat.com>
 <20220519093907.2883394-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519093907.2883394-1-tien.sung.ang@intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 19, 2022 at 05:39:07PM +0800, tien.sung.ang@intel.com wrote:
> Thanks for bringing this up. Yes, you are right that the fpga_mgr sees this
> as an error irrespective of the value. The CvP driver is changed now to just
> indicate the correct error which recommends a retry. To me understanding,
> EAGAIN was this. The fpga manager now looks like is going to return a CvP
> failure in short. 
> A BUSY state does not seem to be able to solve this issue. 
> Even an extended time-out didn't resolve this error state. The current time-out
> is set to 10seconds.   
> However, the main objective is to also handle the error if the CvP firmware
> is not responsive. The error_path flow is to reset the CVP mode and HIP_CLK_SEL bit

Please add your main objective to commit message.

Thanks,
Yilun

> as recommended by the firmware engineers. 
> The flow prescribed here is also an identical copy of working CvP driver 
> which is also owned by Intel. This driver is a downstream driver which is 
> not part of the Linux kernel. We are now porting this differences over to 
> the current upstream CvP driver. 
