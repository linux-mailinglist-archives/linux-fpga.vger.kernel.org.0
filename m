Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D64C592837
	for <lists+linux-fpga@lfdr.de>; Mon, 15 Aug 2022 05:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiHODiD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 14 Aug 2022 23:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiHODiC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 14 Aug 2022 23:38:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1CD13EB4;
        Sun, 14 Aug 2022 20:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660534681; x=1692070681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/vQElSEN56HeDPn/ub86EWgbPJWslC5xOYifqsDS/VA=;
  b=i4v/nLoxh940wbF7iQ0pQK7XTQ9m2/bqohv7dwrix5uJU5/T/k60gFkE
   OZ/609dOpbqKiIhJnAyHigF/nCuq6Y/QgksgvmBXZ4t3hH3TlX1y4Cbep
   s6+ZEj0ZaL09Zzgf2fRNiOyXMgNobvvMMUJt23GJUO5vci55MkwWriEmn
   G6G6ATPk3+ihp+wTvzpPtHGVtLxynaw1GDlpFkMJCFUir8Zd191gtYKDv
   T5A/fwOknAHYjrt3ViDgu9RLswxHwynsPTNxLKQC6KHjli5N7xkwvYwBC
   ppvc2nENjLoxPJeLlp0si3daNPQtPDERjeOTPQN7l5D9nI7Wjye6eO0KC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="289452613"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="289452613"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 20:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="709632239"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 14 Aug 2022 20:37:58 -0700
Date:   Mon, 15 Aug 2022 11:28:55 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: microchip-spi: add missing module author entry
Message-ID: <Yvm9dzhyj6k4+01g@yilunxu-OptiPlex-7050>
References: <20220728075012.3136914-1-conor.dooley@microchip.com>
 <53f6e675-1fc5-fb17-ce6f-aa952d61132f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53f6e675-1fc5-fb17-ce6f-aa952d61132f@redhat.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-07-28 at 05:29:48 -0700, Tom Rix wrote:
> 
> On 7/28/22 12:50 AM, Conor Dooley wrote:
> > Add the missing MODULE_AUTHOR entry for the Microchip spi-slave FPGA
> > programming driver.
> > 
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Tom Rix <trix@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next

> > ---
> >   drivers/fpga/microchip-spi.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> > index bd284c7b8dc9..7436976ea904 100644
> > --- a/drivers/fpga/microchip-spi.c
> > +++ b/drivers/fpga/microchip-spi.c
> > @@ -395,4 +395,5 @@ static struct spi_driver mpf_driver = {
> >   module_spi_driver(mpf_driver);
> >   MODULE_DESCRIPTION("Microchip Polarfire SPI FPGA Manager");
> > +MODULE_AUTHOR("Ivan Bornyakov <i.bornyakov@metrotek.ru>");
> >   MODULE_LICENSE("GPL");
> 
