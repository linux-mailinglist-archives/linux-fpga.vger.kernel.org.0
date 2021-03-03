Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E2832BDBF
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Mar 2021 23:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhCCQaQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Mar 2021 11:30:16 -0500
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:48364 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1355836AbhCCHBt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 3 Mar 2021 02:01:49 -0500
X-Greylist: delayed 670 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 02:01:49 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id A50018014646
        for <linux-fpga@vger.kernel.org>; Wed,  3 Mar 2021 06:50:43 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 33F8C100E7B42;
        Wed,  3 Mar 2021 06:49:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3351:3622:3743:3865:3866:3868:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4384:5007:6117:6120:7652:7901:9025:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13208:13229:13311:13357:13439:14181:14659:14721:14764:21060:21067:21080:21611:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: thumb56_150e8a6276c3
X-Filterd-Recvd-Size: 1626
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Mar 2021 06:49:44 +0000 (UTC)
Message-ID: <70f35c99165ac4dd1846ea2e30b9a1745c364903.camel@perches.com>
Subject: Re: [PATCH V3 XRT Alveo 00/18] XRT Alveo driver overview
From:   Joe Perches <joe@perches.com>
To:     Moritz Fischer <mdf@kernel.org>, Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, Lizhi Hou <lizhih@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, trix@redhat.com,
        robh@kernel.org
Date:   Tue, 02 Mar 2021 22:49:43 -0800
In-Reply-To: <YDLF2Bi3oEhP6A7Q@archbook>
References: <20210218064019.29189-1-lizhih@xilinx.com>
         <YDLF2Bi3oEhP6A7Q@archbook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, 2021-02-21 at 12:43 -0800, Moritz Fischer wrote:
> On Wed, Feb 17, 2021 at 10:40:01PM -0800, Lizhi Hou wrote:
> > This is V3 of patch series which adds management physical function driver for Xilinx
> > Alveo PCIe accelerator cards, https://www.xilinx.com/products/boards-and-kits/alveo.html
> > This driver is part of Xilinx Runtime (XRT) open source stack.
[]
> Please fix the indents all across this patchset. Doesn't checkpatch with
> --strict complain about this?

I glanced at a couple bits of these patches and didn't
notice any of what I consider poor indentation style.

What indent is wrong here?


