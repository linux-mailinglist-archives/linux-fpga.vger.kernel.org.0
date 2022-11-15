Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E820D6293B3
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Nov 2022 09:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiKOI4w (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Nov 2022 03:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiKOI4u (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Nov 2022 03:56:50 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7341A07E;
        Tue, 15 Nov 2022 00:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668502610; x=1700038610;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pd9J1uveG+oppLVIuhPCTzyKg3autS+pjE5czy8gEW8=;
  b=SZ5OB97u5RUjh3Y/VUWMdp2EA94T97C8pANzE2NnIAs9jaDywvcrerte
   SGB4OkJHiG0gBl2hxvnQAOmSNQD/sDhRCANk2/ZWzPGH2ZwiBJztyXQlQ
   VTvlI8+OUE7iWbqif8qqI+tasrvMoo8uHARqxUH5Y+dkvO6ykERtTNmZW
   MT8XG7DChVxgwTTqFfL+gGlMWVxD3MXOmUJ8/g7vTtSekZ/LhaQuR039f
   m7JXQRDxc25AXINO2RCD8GmidYqP+GTji9g9qjNEtIU5/1foenDSCv9jS
   YjCYxemKcYVya6qRK+d+pNsQDbKWDczgBEX2tVjvze+Q2q0LBcvKqpnNU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="314010613"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="314010613"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 00:56:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="967918724"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="967918724"
Received: from karenodx-mobl.ger.corp.intel.com ([10.249.45.214])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 00:56:45 -0800
Date:   Tue, 15 Nov 2022 10:56:43 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
cc:     Russ Weight <russell.h.weight@intel.com>,
        linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/12] mfd: intel-m10-bmc: Create m10bmc_platform_info
 for type specific info
In-Reply-To: <Y3LxmUpqycBoZctF@yilunxu-OptiPlex-7050>
Message-ID: <391c37d8-a9b6-e0cf-5bdc-2182826a33e0@linux.intel.com>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com> <20221108144305.45424-3-ilpo.jarvinen@linux.intel.com> <Y24gJ7fIsUPmhzY2@yilunxu-OptiPlex-7050> <752a1dc-fae6-4431-41cf-a6deaf157ad3@linux.intel.com> <Y3Gg29pGm4DwjOgI@yilunxu-OptiPlex-7050>
 <30c62175-e96f-3911-8176-cac3d4928eb5@intel.com> <Y3LxmUpqycBoZctF@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1382684573-1668502609=:2268"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1382684573-1668502609=:2268
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 15 Nov 2022, Xu Yilun wrote:

> On 2022-11-14 at 17:17:06 -0800, Russ Weight wrote:
> > 
> > 
> > On 11/13/22 17:58, Xu Yilun wrote:
> > > On 2022-11-11 at 13:49:38 +0200, Ilpo Järvinen wrote:
> > >> On Fri, 11 Nov 2022, Xu Yilun wrote:
> > >>
> > >>> On 2022-11-08 at 16:42:55 +0200, Ilpo Järvinen wrote:
> > >>>> BMC type specific info is currently set by a switch/case block. The
> > >>>> size of this info is expected to grow as more dev types and features
> > >>>> are added which would have made the switch block bloaty.
> > >>>>
> > >>>> Store type specific info into struct and place them into .driver_data
> > >>>> instead because it makes things a bit cleaner.
> > >>>>
> > >>>> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> > >>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > >>>> ---
> > >>>>  drivers/mfd/intel-m10-bmc.c       | 50 +++++++++++++++++--------------
> > >>>>  include/linux/mfd/intel-m10-bmc.h | 14 +++++++++
> > >>>>  2 files changed, 41 insertions(+), 23 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> > >>>> index ee167c5dcd29..762808906380 100644
> > >>>> --- a/drivers/mfd/intel-m10-bmc.c
> > >>>> +++ b/drivers/mfd/intel-m10-bmc.c
> > >>>> @@ -208,10 +194,28 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> > >>>>  	return ret;
> > >>>>  }
> > >>>>  
> > >>>> +static const struct intel_m10bmc_platform_info m10bmc_m10_n3000 = {
> > >>>> +	.type = M10_N3000,
> > >>> Is the type enum still useful? Found no usage.
> > >> There's no use within context of this patch series. However, I think there 
> > >> might have been something depending on it in the changes that are not part 
> > >> of this series so I left it in place for now.
> > > I'm not sure how it would be used later. This patch is to eliminate the
> > > "switch (board type) case" block, but similar code is still to be added
> > > later?
> > 
> > Unfortunately, these will be needed later. Consider the following (future)
> > function that has to account for a field that was moved from one register
> > to another:
> > 
> >     static int
> >     m10bmc_sec_status(struct m10bmc_sec *sec, u32 *status)
> >     {
> >             u32 reg_offset, reg_value;
> >             int ret;
> > 
> >             reg_offset = (sec->type == N6000BMC_SEC) ?
> >                     auth_result_reg(sec->m10bmc) : doorbell_reg(sec->m10bmc);
> > 
> >             ret = m10bmc_sys_read(sec->m10bmc, reg_offset, &reg_value);
> >             if (ret)
> >                     return ret;
> > 
> >             *status = rsu_stat(reg_value);
> > 
> >             return 0;
> >     }
> > 
> > With this patch-set, most conditionals are removed, but there will still
> > be some cases where it is needed. If you prefer, we could wait and add
> 
> Why this condition can't be handled in the same manner? I actually hope
> all board type difference been handled in the same way, either by the
> core mfd driver or each subdev driver, but not a mix of the two.

I agree. It is already a TODO item on my list to make that oddity part of 
CSR map.

Also, this is anyway not the same type (mfd and sec have their own set of 
types). I'll just drop the mfd type field for now and might end up doing 
the same for the sec one too.


-- 
 i.

--8323329-1382684573-1668502609=:2268--
