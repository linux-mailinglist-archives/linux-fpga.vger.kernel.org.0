Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A10557C6FA
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Jul 2022 10:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiGUIzH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Jul 2022 04:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiGUIzE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Jul 2022 04:55:04 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C51680512;
        Thu, 21 Jul 2022 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=5IySwf3XGzdy0S9zkwVt+ygnU6w2l4TY/umizNUb2Ss=;
        b=I5pgcldwwXwLNS1ZhOR83NcNMSsVS4g4Y+thqh/OHu6WB7m3oW2LWQwlkW+0zXj/Mhuq2UcccUbSg
         4GpGv4+LRXq8+3g5aa69BavaF753i9d844Fb2FsXoPE6DLRBYNmKcWnATChhHRUJWcMWey02E1MRp6
         AQhA+XozlCNYM488l8KS2xwtfjTMRtBPTeMgCVIKLoRSTo382jwzjsG19frmHQ6uFVywdfBMp1+CYP
         Ck9Og3G6rTSywayOq9KVDl6vsqvCLnVZzb0Cg9GNz4+whVMiNhQza0HXX77SCGBd81OwGnBbvlASfx
         sdr7vKxDFzS0LEr7G8rSlQCQofIYNhw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000009,0.009141)], BW: [Enabled, t: (0.000012,0.000001)], RTDA: [Enabled, t: (0.084208), Hit: No, Details: v2.40.0; Id: 15.52k8uq.1g8fvemiq.ml00; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 21 Jul 2022 11:54:37 +0300
Date:   Thu, 21 Jul 2022 11:54:11 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v5 0/2] Lattice ECP5 FPGA manager
Message-ID: <20220721085411.ennvx74k45sxsimm@h-e2.ddg>
References: <20220719112335.9528-1-i.bornyakov@metrotek.ru>
 <20220721074431.GA1712998@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721074431.GA1712998@yilunxu-OptiPlex-7050>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jul 21, 2022 at 03:44:31PM +0800, Xu Yilun wrote:
> On Tue, Jul 19, 2022 at 02:23:33PM +0300, Ivan Bornyakov wrote:
> > Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> > slave SPI interface with .bit formatted uncompressed bitstream image.
> 
> I didn't have time to looking into the patches yet, but I have some quick
> question.
> 
> Where is the bitstream data writing to? To the FPGA active region or the
> backup nvmem like flash?

Bitstream is written to FPGA's volatile SRAM configuration memory.

> 
> After reconfiguration, how to re-enumerate the hardware devices in the
> newly programmed FPGA region?
> 

I personally describe FPGA-based devices statically in DT overlay within
fpga-region. Of course this approach is error prone to mismatch between
firmware and devices described in DT overlay...

> Thanks,
> Yilun
> 
> > 
> > ChangeLog:
> >   v1 -> v2:
> >     * remove "spi" from compatible string
> >     * reword description in dt-bindings doc
> >     * add reference to spi-peripheral-props.yaml in dt-binding doc
> >     * fix DTS example in dt-bindings doc: 4-spaces indentations, no
> >       undersores in node names.
> >   v2 -> v3:
> >     * fix typo "##size-cells" -> "#size-cells" in dt-bindings example
> >   v3 -> v4:
> >     * dt-bindings: reword description
> >     * dt-bindings: revert props order
> >   v4 -> v5:
> >     * dt-bindings: remove trailing dot from title
> >     * dt-bindings: reword description to avoid driver reference
> >     * dt-bindings: add "Reviewed-by: Krzysztof Kozlowski" tag
> > 
> > Ivan Bornyakov (2):
> >   fpga: ecp5-spi: add Lattice ECP5 FPGA manager
> >   dt-bindings: fpga: add binding doc for ecp5-spi fpga mgr
> > 
> >  .../bindings/fpga/lattice,ecp5-fpga-mgr.yaml  |  74 +++++
> >  drivers/fpga/Kconfig                          |   7 +
> >  drivers/fpga/Makefile                         |   1 +
> >  drivers/fpga/ecp5-spi.c                       | 275 ++++++++++++++++++
> >  4 files changed, 357 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
> >  create mode 100644 drivers/fpga/ecp5-spi.c
> > 
> > -- 
> > 2.37.1
> > 

