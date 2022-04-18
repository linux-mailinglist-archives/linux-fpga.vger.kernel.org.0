Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B210505447
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Apr 2022 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbiDRNDf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Apr 2022 09:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240789AbiDRNBj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Apr 2022 09:01:39 -0400
X-Greylist: delayed 481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Apr 2022 05:42:14 PDT
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09EA32045
        for <linux-fpga@vger.kernel.org>; Mon, 18 Apr 2022 05:42:14 -0700 (PDT)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id C98A621F48;
        Mon, 18 Apr 2022 12:34:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id BABB22002B;
        Mon, 18 Apr 2022 12:34:03 +0000 (UTC)
Message-ID: <d56ad1bc0ef918cc8395b7c0ec7bdd10baf4c1f6.camel@perches.com>
Subject: Re: [PATCH v4 2/5] fpga: fix for coding style issues
From:   Joe Perches <joe@perches.com>
To:     Nava kishore Manne <navam@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Date:   Mon, 18 Apr 2022 05:34:02 -0700
In-Reply-To: <SN6PR02MB45763D1B949353F99AAFE7D8C2F39@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
         <20220416133719.3382895-3-nava.manne@xilinx.com>
         <ac22068dad06fd61f2e82c0bf7c0f58a4e5df050.camel@perches.com>
         <SN6PR02MB45763D1B949353F99AAFE7D8C2F39@SN6PR02MB4576.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: epzo5oz5kfdybfgi53hfa7jj89tnxo9k
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: BABB22002B
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+NFs9m+djNp+pOCjBVEkayfxYTc+TurQw=
X-HE-Tag: 1650285243-748919
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 2022-04-18 at 09:54 +0000, Nava kishore Manne wrote:
> Hi Joe,
> 
> 	Please find my response inline.
> 
> > -----Original Message-----
> > From: Joe Perches <joe@perches.com>
> > Sent: Saturday, April 16, 2022 10:29 PM

> > On Sat, 2022-04-16 at 19:07 +0530, Nava kishore Manne wrote:
> > > fixes the below checks reported by checkpatch.pl Lines should not end
> > > with a '('
> > > Alignment should match open parenthesis
> > 
> > in fpga-mgr:
> > 	Another possibillty would be to change the function arguments
> > 
> > and
> > 
> > in fpga-region:
> > 	Ideally keep the include declaration and definition styles synced
> 
> These changes are targeted to fix the checks reported by checkpatch.pl without touching the actual functionality.

Hello.

I am the checkpatch maintainer.

The goal of the checkpatch script is simply to mark things that
generally don't conform to the typical kernel coding style not
to mandate that all of the messages it emits is dicta.

checkpatch is a stupid little script.  It has no taste.

Please take what I wrote with a little consideration rather than
follow the advise of a brainless script.


