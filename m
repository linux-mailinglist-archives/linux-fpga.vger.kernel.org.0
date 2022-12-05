Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32897642B7C
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Dec 2022 16:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiLEPSY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Dec 2022 10:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiLEPSU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Dec 2022 10:18:20 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634F6F5A2;
        Mon,  5 Dec 2022 07:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670253491; x=1701789491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mAbRJCKI1t/EZ8rmJVg6IP2WKkpnUclRj8rRfA4YWoY=;
  b=lTfzI7mBgxEHgymeeplQkauB9MeiIws44JHryD9iXV3fRdobW2uRxGb7
   Xg+a6172bUUEmzg8uC4cHAsAEhdb2Sv5JzMU4s6WU/PHWbfWCGXqQphPK
   eouCxW700iqTr84XhK4i7MG4IrLFcHfiil3S4ZweciJnLEXUVZD1mvhzV
   0oltoM59ZWDctf64GC49x1GvYNlWH0pLXSFr3t3vcW3CcChuJkGygPt9A
   EPdMQamR8tMmA9mJ/MZIo1oTcHwSPAHKjv6EmBRTYPmtxGn6DI9iotMT1
   Bo6GM9XqR5+7JN1pZhUTw5KUV1XxilhLTxRLxNo0Vbt5+/2ss2Xn8r+Q3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="314019853"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="314019853"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 07:18:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="647974000"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="647974000"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2022 07:18:08 -0800
Date:   Mon, 5 Dec 2022 23:08:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] mfd: intel-m10-bmc: Add PMCI driver
Message-ID: <Y44JaLtAnTll4gU0@yilunxu-OptiPlex-7050>
References: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com>
 <20221202100841.4741-8-ilpo.jarvinen@linux.intel.com>
 <Y4ox5J0junaUYyT7@yilunxu-OptiPlex-7050>
 <855d463e-fb84-1910-f53-58e6b0a633a4@linux.intel.com>
 <Y43eejWSYIBIlUKB@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y43eejWSYIBIlUKB@sirena.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-05 at 12:05:14 +0000, Mark Brown wrote:
> On Mon, Dec 05, 2022 at 11:51:15AM +0200, Ilpo Järvinen wrote:
> > On Sat, 3 Dec 2022, Xu Yilun wrote:
> > > On 2022-12-02 at 12:08:39 +0200, Ilpo Järvinen wrote:
> 
> > > > +struct regmap *__devm_m10_regmap_indirect(struct device *dev,
> 
> > > We name the file intel-m10-bmc-pmci-xxx.c, and this function
> > > xx_m10_regmap_xx(). But I can see the implementation is just about the indirect
> > > bus which from your commit message could be used by various DFL features
> > > like HSSI or PMCI. So is it better we put the implementation in
> > > drivers/fpga and name the file dfl-indirect-regmap.c and the
> > > initialization function dfl_indirect_regmap_init()?
> 
> > I guess that would be doable unless Mark objects. My understanding was 
> > that he preferred to have in the driver that is currently using it.
> 
> > Mark, any opinion on this?
> 
> The above does not look good.  As I have said several times now drivers
> implementing their own regmap operations should use the reg_read() and
> reg_write() operations in regmap_config when allocating their regmap
> unless they're doing something unusual.  There are a few cases where it
> makes sense but nothing I've seen here makes it look like this is one of
> them.  Most of the current users don't fit.

It is good for now to implement the indirect access interface in
regmap_config, as intel-m10-bmc is the only one who uses it. But I'm not
sure when a second IP block(like HSSI) in intel FPGA uses it, how to
implement? A shared library?

Some background about hardware:
Several IP blocks in intel FPGA integrate the same mmio register layout
(so called indirect access interface here) as the bridge to the IP's real
registers address space. Like:

 +---------+          +---------+
 | m10 BMC |          |  HSSI   |
 +---------+          +---------+
 |indirect |          |indirect |
 | access  |          | access  |
 |  MMIOs  |          |  MMIOs  |
 +----+----+          +----+----+
      |                    |
      |                    |
 +----+-----+         +---------+
 |m10 bmc   |         | HSSI    |
 |registers |         |registers|
 +----------+         +---------+

Thanks,
Yilun

> 
> Please, just implement a normal driver using a normal regmap_config as
> I've repeatedly said you should if you don't want to provide something
> generic.


