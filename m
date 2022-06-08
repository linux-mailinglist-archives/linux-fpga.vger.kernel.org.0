Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34028542C6F
	for <lists+linux-fpga@lfdr.de>; Wed,  8 Jun 2022 12:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbiFHKAZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Jun 2022 06:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbiFHJ7q (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 8 Jun 2022 05:59:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB9C77F14;
        Wed,  8 Jun 2022 02:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654680855; x=1686216855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rHc0JnVmQcL4RbsGuNBgaGCDtKoiJltSElvmMgOV7G8=;
  b=g0DVuNkDD9jYxetm0JrRimNhtZ+bjNhV7iN9GPQIcRt9iMeiHef6l+Iv
   K8GqyQUThnU7meqBBWGkTpBvJIfMKNxxgoMNjsACzMbCfgKx9iKDsVilQ
   MMOgZQ48Wk+8LR6qhjWniFvjAajqz8kABtOpo+sVfFxXFe7ZE7G7io7jb
   ILBZkyXnAcZn5rJ12a1/ZT4FhdPvsuvHFFZuhwi+EXshNqQMQVUaGmXbr
   SI5Mgox6Yves4j0igEGQnQWusjKOQt9bKtcSt20f49dey4bMlIwUsca/l
   cmS+U5ovvPQJr4J1AhK6Z9gl0Kt+yckk7P+wMfE+qHmOfpm8+nDe74Q0f
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277677350"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="277677350"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="683232075"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2022 02:34:11 -0700
Date:   Wed, 8 Jun 2022 17:26:17 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        hao.wu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, marpagan@redhat.com,
        lgoncalv@redhat.com, matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v23 1/5] mfd: intel-m10-bmc: Rename n3000bmc-secure driver
Message-ID: <20220608092617.GE481269@yilunxu-OptiPlex-7050>
References: <20220606160038.846236-1-russell.h.weight@intel.com>
 <20220606160038.846236-2-russell.h.weight@intel.com>
 <YqBT1O9dxAqeFphE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YqBT1O9dxAqeFphE@google.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 08, 2022 at 08:46:28AM +0100, Lee Jones wrote:
> On Mon, 06 Jun 2022, Russ Weight wrote:
> 
> > The n3000bmc-secure driver has changed to n3000bmc-sec-update. Update
> > the name in the list of the intel-m10-bmc sub-drivers.
> > 
> > Tested-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > ---
> > v23:
> >   - Rebased for 5.19-rc1
> > v22:
> >   - Added Tested-by tag from Tianfei and Acked-by tag from Yilun.
> > v21:
> >   - No change
> > v20:
> >   - No change
> > v19:
> >   - No change
> > v18:
> >   - No change
> > v17:
> >   - This is a new patch to change in the name of the secure update
> >     driver.
> > ---
> >  drivers/mfd/intel-m10-bmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

I updated the tag in fpga/for-next

Thanks,
Yilun

> 
> -- 
> Lee Jones [李琼斯]
> Principal Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
