Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBE85A2B69
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Aug 2022 17:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242448AbiHZPgP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Aug 2022 11:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243036AbiHZPgF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 26 Aug 2022 11:36:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E9332ED2;
        Fri, 26 Aug 2022 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661528163; x=1693064163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uHvW9uDwxRGySey1R8sl3cAN9zKy6edBHbMcHu5b++Y=;
  b=G2pEkUejzpep8HOpz4zlc13VG1pP98p4u/rq1g2MxcnkJPFLqxkanXDM
   8oFCLV5IhIoK1PxGMSt8vqziyMKNzX8U+L1GztW8Mj4yBvIQ2/zDD8TuW
   n7NopYECUqrioSUwMxfMvkhNhJobRVeXolBf9qm6T9L1ulFYZ5ouEFHEk
   YUeERyhMeyxPe12nvQhxkG+RCemo/J232izrw+foeDIAP6e3VpRqqMlKN
   2ibi5XQv0NlZYZR8YfI8l80asLJTnotJ+d7TB5anar4hGrW0ho/DFugnm
   5v5bIBMSKiImeExCg+Hvv1F7314G8KnfPUnKMNEpF54qBURiOMrzBYanf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="292110863"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="292110863"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 08:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="640097687"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2022 08:35:59 -0700
Date:   Fri, 26 Aug 2022 23:26:44 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Sascha Hauer <sha@pengutronix.de>, j.zink@pengutronix.de,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        robh+dt@kernel.org, mdf@kernel.org, kernel@pengutronix.de,
        hao.wu@intel.com
Subject: Re: [PATCH 00/16] Add support for Lattice MachXO2 programming via I2C
Message-ID: <YwjmNAmfMSSTrbkS@yilunxu-OptiPlex-7050>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
 <20220825152514.9926-1-i.bornyakov@metrotek.ru>
 <20220826082539.GA12909@pengutronix.de>
 <20220826090042.jhngyeufei55b5c2@h-e2.ddg>
 <20220826091912.xunn3cv3gwhktjib@h-e2.ddg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826091912.xunn3cv3gwhktjib@h-e2.ddg>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-26 at 12:19:12 +0300, Ivan Bornyakov wrote:
> On Fri, Aug 26, 2022 at 12:00:44PM +0300, Ivan Bornyakov wrote:
> > On Fri, Aug 26, 2022 at 10:25:39AM +0200, Sascha Hauer wrote:
> > > Hi Ivan,
> > > 
> > > On Thu, Aug 25, 2022 at 06:25:14PM +0300, Ivan Bornyakov wrote:
> > > > Hi, Johannes!
> > > > 
> > > > I just came across your patches. Surprisingly, our work interferes.
> > > > 
> > > > I recently posted patch-series for configuring ECP5 and was asked to make
> > > > generalized sysCONFIG driver with support for both ECP5 and MachXO2, which
> > > > I did. Sadly I don't have hardware with MachXO2, but you clearly do :)
> > > > 
> > > > Please, take a look at
> > > > 
> > > > https://lore.kernel.org/linux-fpga/20220825112433.14583-1-i.bornyakov@metrotek.ru/
> > > > 
> > > > and please help test MachXO2 variant. When we pull this off, you may add I2C
> > > > interface on top.
> > > 
> > > You are adding a new driver for something we already have a driver for
> > > in the tree.
> > 
> > My intent was to add new driver and drop old one once the new driver is
> > proven to be working.
> > 
> > > The final goal should be that we only have a single driver
> > > for sysconfig based FPGAs in the tree.
> > 
> > It is.
> > 
> > > Johannes' series is a step in
> > > that direction: He cleans up the existing driver and starts abstracting
> > > out common sysconfig functions so that they can be used by both the I2C
> > > and SPI interface. He just told me that the abstraction is likely not
> > > enough to integrate ECP5 support right away, one reason being that the
> > > machxo2 has a flash whereas the ECP5 does not.
> > > 
> > > Unless you can explain why the existing driver is broken beyond repair
> > > I think we should rather incrementally improve the existing driver
> > > instead of adding a new one with a conflicting compatible.
> > 
> > Yeah, conflicting compatible was my oversight.
> > 
> 
> Wait! They are not conflicting :) The new one is "lattice,machxo2-fpga-mgr",
> the old one is "lattice,machxo2-slave-spi"
> 
> > > So despite you were in the room earlier I think you should rather base
> > > your work on Johannes' series.
> > 
> > We on par here. You guys didn't join ongoing work, I didn't rework
> > existing driver.

I didn't look into the code yet, so maybe some misunderstanding.

I'd rather we pay more attention on the code design for the FULL feature
of this sysCONFIG interface, rather than worrying about whose patches should
go first.

So just review patches for each other and collabrate for a well design,
then your features can be accepted faster.

Thanks,
Yilun

> > 
> > > 
> > > Just my 2 cents, maybe one of the maintainers has a few words on it.
> > > 
> > > Sascha
> > > 
> > > 
> > > -- 
> > > Pengutronix e.K.                           |                             |
> > > Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> > > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
