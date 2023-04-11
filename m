Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38C36DD999
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Apr 2023 13:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDKLko (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Apr 2023 07:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjDKLko (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 11 Apr 2023 07:40:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C354435B1;
        Tue, 11 Apr 2023 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681213241; x=1712749241;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q1KmnT6CP3gcYAB98ih7TpWtjuH/X4ISON3W+ihbGac=;
  b=NN5LEVK/xcK9IfYFRFoPG20GfiMA6lGBXYYQ0rBPbLLa5Pj3+n63OB5E
   RPf4wsez2ggP4XXIu9yhbN/FWukRVIXK4FSAkqxuXbvySyGj26pj7Zofh
   BtyNa7vdlTQYePK3VxWJNO0eKoF5RSyGViLIOCeMiZMAy+1VBEC2rX0Be
   etY+Df0imumuwbKIMdSvpEdA/Er8x+xlsrhZUw+Jy3G5U4MwHnSnoZU1+
   kyWkZfT2yk9zjb6rnp+cK9jqLR+m11t/MmV6Oo51bnUTd7Q70uQv0US4l
   bf+rzqa8J3sdAiJIcrp8AiYmLFhas8TaiCcENzzCSq+ypUXMv5fJmtP/0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="408732615"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="408732615"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 04:40:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="638785598"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="638785598"
Received: from rwambsga-mobl.ger.corp.intel.com ([10.251.212.142])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 04:40:38 -0700
Date:   Tue, 11 Apr 2023 14:40:33 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] mfd: intel-m10-bmc: Move core symbols to own
 namespace
In-Reply-To: <ZC+3msi6ovoF55tr@yilunxu-OptiPlex-7050>
Message-ID: <a67058bc-8265-add0-3b89-8ee310e871b6@linux.intel.com>
References: <20230405080152.6732-1-ilpo.jarvinen@linux.intel.com> <20230405080152.6732-2-ilpo.jarvinen@linux.intel.com> <ZC+3msi6ovoF55tr@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1253313675-1681213247=:2109"
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1253313675-1681213247=:2109
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 7 Apr 2023, Xu Yilun wrote:

> On 2023-04-05 at 11:01:49 +0300, Ilpo Järvinen wrote:
> > Create INTEL_M10_BMC_CORE namespace for symbols exported by
> > intel-m10-bmc-core.
> 
> Is it necessary for handshake register, or just an independent
> improvement?

It's independent improvement.

> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/mfd/intel-m10-bmc-core.c | 2 +-
> >  drivers/mfd/intel-m10-bmc-pmci.c | 1 +
> >  drivers/mfd/intel-m10-bmc-spi.c  | 1 +
> >  3 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
> > index dac9cf7bcb4a..b94412813887 100644
> > --- a/drivers/mfd/intel-m10-bmc-core.c
> > +++ b/drivers/mfd/intel-m10-bmc-core.c
> > @@ -98,7 +98,7 @@ const struct attribute_group *m10bmc_dev_groups[] = {
> >  	&m10bmc_group,
> >  	NULL,
> >  };
> > -EXPORT_SYMBOL_GPL(m10bmc_dev_groups);
> > +EXPORT_SYMBOL_NS_GPL(m10bmc_dev_groups, INTEL_M10_BMC_CORE);
> >  
> >  int m10bmc_dev_init(struct intel_m10bmc *m10bmc, const struct intel_m10bmc_platform_info *info)
> 
> Why this function is not included in namespace?

It was not left out on purpose, I'll add it there.

-- 
 i.

--8323329-1253313675-1681213247=:2109--
