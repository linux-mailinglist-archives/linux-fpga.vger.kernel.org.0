Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139D065973E
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Dec 2022 11:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiL3KXa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Dec 2022 05:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiL3KX3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Dec 2022 05:23:29 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE60917E37;
        Fri, 30 Dec 2022 02:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672395808; x=1703931808;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qo29QrWsuU7LzMUtenaPcBp4E8W7PbGqVqlhZBfF2pM=;
  b=oEAI7FKU5GrLhzpIEDA2LSynN6OagWzd63u4t199MS9bZL5xqozt4w9E
   P2+ebqRTJONDBo4J2n5q0dPmADt/ahE6C+bEbW7Ts7ISP1dJ+hmGA4a4+
   +edmAi5GAvsiUpyKi5ZRaKFprx0402k0ijg81Y95AMH5W9XISIqLVobm/
   LDlE8loCYAd3oCHSHdHMmA/JqmEeVsErZJlQj5YSQ+l0zmFIhUSPPEjV2
   1kVSUC7umPzfHL+nCFMsFp97APB8uvWlpCumEjdkf8BQ51ZQJmudrZBGm
   yUT/eMq8l3yi2U0/rui17QGD3iMR8XqT1Xt+YlsYy80hmZPWOadfaXXdj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="348397556"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="348397556"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 02:23:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="684435860"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="684435860"
Received: from vsemouch-mobl.ger.corp.intel.com ([10.249.41.102])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 02:23:23 -0800
Date:   Fri, 30 Dec 2022 12:23:18 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 08/10] fpga: m10bmc-sec: Differentiate rsu status from
 doorbell in csr map
In-Reply-To: <Y65p0kEZjyVt2pgr@yilunxu-OptiPlex-7050>
Message-ID: <6d9ccd20-2c13-e352-c9e9-804ea3dadf@linux.intel.com>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com> <20221226175849.13056-9-ilpo.jarvinen@linux.intel.com> <Y65p0kEZjyVt2pgr@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-447113576-1672395808=:2020"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-447113576-1672395808=:2020
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 30 Dec 2022, Xu Yilun wrote:

> On 2022-12-26 at 19:58:47 +0200, Ilpo Järvinen wrote:
> > The rsu_status field moves from the doorbell register to the auth
> > result register in the PMCI implementation of the MAX10 BMC. Refactor
> > the sec update driver code to handle two distinct registers (rsu_status
> > field was added into csr map already when it was introduced but it was
> > unused until now).
> > 
> > Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/fpga/intel-m10-bmc-sec-update.c | 68 ++++++++++++++++---------
> >  include/linux/mfd/intel-m10-bmc.h       |  2 +-
> >  2 files changed, 46 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> > index 6e58a463619c..1fe8b7ff594c 100644
> > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > @@ -251,7 +251,7 @@ static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
> >  	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> >  	u32 auth_result;
> >  
> > -	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
> > +	dev_err(sec->dev, "Doorbell: 0x%08x\n", doorbell);
> >  
> >  	if (!m10bmc_sys_read(sec->m10bmc, csr_map->auth_result, &auth_result))
> >  		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
> > @@ -279,6 +279,30 @@ static bool rsu_progress_busy(u32 progress)
> >  		progress == RSU_PROG_PROGRAM_KEY_HASH);
> >  }
> >  
> > +static int m10bmc_sec_progress_status(struct m10bmc_sec *sec, u32 *doorbell,
> 
> Please try to rename the parameters, to indicate u32 *doorbell is the
> raw value from doorbell register, and u32 *progress & status are
> software managed info.

I'll try to do that.
 
> > +				      u32 *progress, u32 *status)
> > +{
> > +	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> > +	u32 status_reg;
> > +	int ret;
> > +
> > +	ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, doorbell);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (csr_map->doorbell != csr_map->rsu_status) {
> 
> I prefer not to complicate the csr map filling in intel-m10-bmc, just invalid
> the addr value if there is no such register for the board.

I'm sorry but I didn't get the meaning of your comment. Could you please 
rephrase?

My guess is that you might have tried to say that if there's no register 
for rsu_status, mark it not existing in csr map? But the field exists in 
both cases, it's just part of a different register (doorbell or 
auth_result) so if I use that kind of "register doesn't exist" condition, 
it would apply to both cases.

> > @@ -330,21 +350,20 @@ static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
> >  	if (ret)
> >  		return FW_UPLOAD_ERR_RW_ERROR;
> >  
> > -	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
> > -				       csr_map->base + csr_map->doorbell,
> > -				       doorbell,
> > -				       rsu_start_done(doorbell),
> > -				       NIOS_HANDSHAKE_INTERVAL_US,
> > -				       NIOS_HANDSHAKE_TIMEOUT_US);
> > +	ret = read_poll_timeout(m10bmc_sec_progress_status, err,
> > +				err < 0 || rsu_start_done(doorbell, progress, status),
> > +				NIOS_HANDSHAKE_INTERVAL_US,
> > +				NIOS_HANDSHAKE_TIMEOUT_US,
> > +				false,
> > +				sec, &doorbell, &progress, &status);
> >  
> >  	if (ret == -ETIMEDOUT) {
> >  		log_error_regs(sec, doorbell);
> >  		return FW_UPLOAD_ERR_TIMEOUT;
> > -	} else if (ret) {
> > +	} else if (err) {
> >  		return FW_UPLOAD_ERR_RW_ERROR;
> >  	}
> >  
> > -	status = rsu_stat(doorbell);
> >  	if (status == RSU_STAT_WEAROUT) {
> >  		dev_warn(sec->dev, "Excessive flash update count detected\n");
> >  		return FW_UPLOAD_ERR_WEAROUT;
> > @@ -393,7 +412,7 @@ static enum fw_upload_err rsu_prog_ready(struct m10bmc_sec *sec)
> >  static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
> >  {
> >  	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> > -	u32 doorbell;
> > +	u32 doorbell, status;
> >  	int ret;
> >  
> >  	ret = regmap_update_bits(sec->m10bmc->regmap,
> > @@ -418,7 +437,10 @@ static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
> >  		return FW_UPLOAD_ERR_RW_ERROR;
> >  	}
> >  
> > -	if (!rsu_status_ok(rsu_stat(doorbell))) {
> > +	ret = m10bmc_sys_read(sec->m10bmc, csr_map->rsu_status, &status);
> 
> Same as above, please just handle the detailed register definition 
> differences in this driver, not in csr map.

Earlier you were having the exactly opposite opinion:

https://lore.kernel.org/linux-fpga/20221108144305.45424-1-ilpo.jarvinen@linux.intel.com/T/#me2d20e60d7feeafcdeeab4d58bd82787acf3ada9

So which way you want it? Should I have the board types here in the sec 
update drivers as a second layer of differentiation or not?


-- 
 i.

--8323329-447113576-1672395808=:2020--
