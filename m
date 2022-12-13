Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E1064AF8A
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Dec 2022 06:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiLMF5L (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Dec 2022 00:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiLMF5H (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Dec 2022 00:57:07 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3951A395;
        Mon, 12 Dec 2022 21:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670911026; x=1702447026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pcLW7bKOVb650cK7BeKpNUl7dgr1RoR9bTIb3VzwJzA=;
  b=FH10XkV9AHVJe32FyD2yyCShj7WqDqvd+bF0VYEM5o6dBM8T0uOLc3bb
   7C1ipOQIqBoRDwYqxwaQMp1a4MopdpYUsDee/DHm2hla0PsywCqNPn+MN
   oH/9GjoKr2RNP7y8BKZoC175tZV1GuJ8Vq092vWq/h64Kx0uNAtQaQEXp
   1Brz61Um/VBWV6R8QWtRFahDsOXV6ph063RFnlC27JLJf5nxRJTpOMfnG
   J0BXmDjd2caGbNzChpG6JmzWihJxd8jI65tmdoWYfDEqPpOsVUZzjSNTf
   6Srrd9lT0XFt+HggWPeWxhEHEUMeyFEF6CNJS12Vm9XuKJbfrqG4ZrL0v
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="315688359"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="315688359"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 21:57:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="737262414"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="737262414"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2022 21:57:03 -0800
Date:   Tue, 13 Dec 2022 13:47:12 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/8] mfd: intel-m10-bmc: Add PMCI driver
Message-ID: <Y5gR4ETBSRQd6uz+@yilunxu-OptiPlex-7050>
References: <20221211103913.5287-1-ilpo.jarvinen@linux.intel.com>
 <20221211103913.5287-8-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221211103913.5287-8-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-11 at 12:39:12 +0200, Ilpo Järvinen wrote:
> Add the mfd driver for the Platform Management Component Interface
> (PMCI) based interface of Intel MAX10 BMC controller.
> 
> PMCI is a software-visible interface, connected to card BMC which
> provided the basic functionality of read/write BMC register. The access
> to the register is done indirectly via a hardware controller/bridge
> that handles read/write/clear commands and acknowledgments for the
> commands.
> 
> Previously, intel-m10-bmc provided sysfs under
> /sys/bus/spi/devices/... which is generalized in this change because
> not all MAX10 BMC appear under SPI anymore.
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Co-developed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>
