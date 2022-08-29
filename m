Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D745A45EE
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Aug 2022 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiH2JRv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Aug 2022 05:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiH2JRu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 Aug 2022 05:17:50 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E435AA08;
        Mon, 29 Aug 2022 02:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=cIZGy8AFz0cIbgd3MkyM5IT0va3Zeq4n+wa1IkV9nl0=;
        b=LePJvJfdE1GqQOVmO7TTja09TsA90wcCFlJLkK8mpzSb0Uc0BWY+leipDvJ0yoI90e2RXHPVVvv/N
         pF5ZFCI5UUsenTsAVGSK0Bh424xhVdShOoQL3pLo/gUKnkq43Qnv5G1cUjC6F+l0ptEGsfiITs38rK
         O+q/wW8yzKvUoifebaDocp4xYuzPLia7ALXXQEc6GAsedhQhYYQmAmywA0CdJSbS5ISaDHcERO9N8K
         s6qWnv0G8ZoDLkOlGK8KKlPhAQiVcw66VvQ1PFAC/r/aXHS+JebqyvMeyBCfIKGpBCiCkQveeODVDs
         o6YjVC1LXYvYK62XSpmgyoF3DwUw6Bg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000010,0.007372)], BW: [Enabled, t: (0.000017,0.000001)], RTDA: [Enabled, t: (0.075475), Hit: No, Details: v2.41.0; Id: 15.52kafc.1gbke8nv1.299r; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 29 Aug 2022 12:17:34 +0300
Date:   Mon, 29 Aug 2022 12:16:35 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v8 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <20220829091635.odubpbqdgb4i64jm@h-e2.ddg>
References: <20220825112433.14583-1-i.bornyakov@metrotek.ru>
 <20220825112433.14583-2-i.bornyakov@metrotek.ru>
 <Ywxp9XgcjM0LIIC2@yilunxu-OptiPlex-7050>
 <20220829082740.glbcu5464zs3hceh@h-e2.ddg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829082740.glbcu5464zs3hceh@h-e2.ddg>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 29, 2022 at 11:27:40AM +0300, Ivan Bornyakov wrote:
> On Mon, Aug 29, 2022 at 03:25:41PM +0800, Xu Yilun wrote:
> > On 2022-08-25 at 14:24:32 +0300, Ivan Bornyakov wrote:
> > > Add support to the FPGA manager for programming Lattice ECP5 and MachXO2
> > > FPGAs over slave SPI sysCONFIG interface.
> > > 
> > > ... snip ...
> > >
> > > +
> > > +static const struct spi_device_id sysconfig_spi_ids[] = {
> > > +	{
> > > +		.name = "ecp5-fpga-mgr",
> > > +		.driver_data = (kernel_ulong_t)ecp5_probe,
> > > +	}, {
> > > +		.name = "machxo2-fpga-mgr",
> > > +		.driver_data = (kernel_ulong_t)machxo2_probe,
> > 
> > Putting the whole probe flow in driver_data is the same as providing 2
> > drivers. The purpose is not to put all the code in one file.
> > 
> 
> Sorry, I don't understand what you suggest. Separate file for each
> specific FPGA?
> 

In v9 I was about to split this to sysconfig.c with sysCONFIG interface
port functions independent of port type + sysconfig-spi.c with functions
specific for SPI port. In this approach there is opportunity for
Johannes to add sysconfig-i2c.c with MachXO2's I2C port while reusing
fpga_manager_ops->state(), fpga_manager_ops->write_init() and
fpga_manager_ops->write_complete().

IDs structs array in sysconfig-spi.c still contains data with FPGA
specific probe, though.

