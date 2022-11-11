Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145C5625B18
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Nov 2022 14:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiKKNQz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 11 Nov 2022 08:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiKKNQv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 11 Nov 2022 08:16:51 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF9371F24;
        Fri, 11 Nov 2022 05:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668172610; x=1699708610;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=7za9uzbKTygHmBXRxPFizOV1Bgw31fqfj2U9mTEHnRc=;
  b=H9Z5G6BCMXX71XSJOSh5NUcDxCKbV37j8X5ce967rhDv3ntfCRgyvmws
   Bfcj9ihGSKE7dq9bl8GPvAuqJR7rTQ7tIf4BjfbUsbi3Yq8PV7Q9B8v91
   wX29YLdNgaBc0gGcQiq/Y6Du5e+jNWdTsHuombNLH1RWOEaxVG0zAGvUH
   fvhi5wGb7lckRkeugAX/+MwkYWT0YVNOY1huzEgssm4yKZUZpSNsh0N5u
   wr6NMsOgUlpTo4BRetzIOx7/1szD8Yhig7N8oYrN+Njap45/sVCoHIvF9
   9mYElh/T/3ESxLL5kQ2rbGOCkhXAw6kAIvDY/54Q1zvsMRtN6/moK1oKF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="311597253"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="311597253"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 05:16:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="706538341"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="706538341"
Received: from iglushko-mobl1.ger.corp.intel.com ([10.249.44.68])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 05:16:45 -0800
Date:   Fri, 11 Nov 2022 15:16:42 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/12] mfd: intel-m10-bmc: Add PMCI driver
In-Reply-To: <Y24eF6OsRTFGcB/F@yilunxu-OptiPlex-7050>
Message-ID: <ce691f6f-4519-5589-4a96-58f17476ee@linux.intel.com>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com> <20221108144305.45424-11-ilpo.jarvinen@linux.intel.com> <Y24eF6OsRTFGcB/F@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1610038758-1668172156=:1606"
Content-ID: <799f7c47-89b-b64d-b4c-d6ffa22ef017@linux.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1610038758-1668172156=:1606
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <35f65f-3095-9217-ff4c-818d95be3de@linux.intel.com>

On Fri, 11 Nov 2022, Xu Yilun wrote:
> On 2022-11-08 at 16:43:03 +0200, Ilpo Järvinen wrote:

> > +static int pmci_probe(struct dfl_device *ddev)
> > +{
> > +	struct device *dev = &ddev->dev;
> > +	struct pmci_device *pmci;
> > +
> > +	pmci = devm_kzalloc(dev, sizeof(*pmci), GFP_KERNEL);
> > +	if (!pmci)
> > +		return -ENOMEM;
> > +
> > +	pmci->m10bmc.dev = dev;
> > +	pmci->dev = dev;
> 
> I don't see its usage.

It's used by dev_err() in patch 11/12.

> > +	pmci->base = devm_ioremap_resource(dev, &ddev->mmio_res);
> > +	if (IS_ERR(pmci->base))
> > +		return PTR_ERR(pmci->base);
> > +
> > +	pmci->m10bmc.regmap =
> > +		devm_regmap_init_indirect(dev,
> > +					  pmci->base + M10BMC_PMCI_INDIRECT_BASE,
> > +					  &m10bmc_pmci_regmap_config);
> > +	if (IS_ERR(pmci->m10bmc.regmap))
> > +		return PTR_ERR(pmci->m10bmc.regmap);
> > +
> > +	return m10bmc_dev_init(&pmci->m10bmc, &m10bmc_m10_n6000);
> > +}
> > +
> > +#define FME_FEATURE_ID_PMCI_BMC	0x12
> > +
> > +static const struct dfl_device_id pmci_ids[] = {
> > +	{ FME_ID, FME_FEATURE_ID_PMCI_BMC },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(dfl, pmci_ids);
> > +
> > +static struct dfl_driver pmci_driver = {
> > +	.drv	= {
> > +		.name       = "intel-m10-bmc",
> > +		.dev_groups = m10bmc_dev_groups,
> > +	},
> > +	.id_table = pmci_ids,
> > +	.probe    = pmci_probe,
> > +};
> > +
> > +module_dfl_driver(pmci_driver);
> 
> Maybe change the name. This is still a MAX10 bmc driver, pmci is just the
> interface to max10.

I've now improved the naming consistency to basically have m10bmc_pmci_ 
as the prefix for many things that weren't previously.


-- 
 i.
--8323329-1610038758-1668172156=:1606--
