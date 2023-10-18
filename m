Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EEC7CE693
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Oct 2023 20:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjJRS2j (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Oct 2023 14:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjJRS2j (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 18 Oct 2023 14:28:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCEC109
        for <linux-fpga@vger.kernel.org>; Wed, 18 Oct 2023 11:28:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F01C433C8;
        Wed, 18 Oct 2023 18:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697653717;
        bh=pZ6EybK7L/IO626/W1WQxqdEqd2kDhZ0iz/W9yN+YOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=py5OuRkXTGAX2YjZOys6OXgtgi5IVtbLM4P754vcQJohaULRjC5lU4j7/rM+nAO9P
         M/+SV2/fpj267og+CmEFqH0i8VHeCxJ4aIneaN0BVLoGvxtFLkOawKVZ0k0c4EF6Fa
         bX5ez1F9vHnX+KQzh4cbFyx+HP7599V9zJnvDU9k=
Date:   Wed, 18 Oct 2023 20:28:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Xu Yilun <yilun.xu@linux.intel.com>, yilun.xu@intel.com,
        linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.6-final
Message-ID: <2023101857-surgical-gab-8469@gregkh>
References: <ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050>
 <2023101730-budding-spree-1471@gregkh>
 <ZS88oHe8T69/Kks7@yilunxu-OptiPlex-7050>
 <2023101825-ligament-undergrad-cc4d@gregkh>
 <e178f915-fc65-48a1-abab-05d1202319a4@redhat.com>
 <2023101848-smith-tastiness-1459@gregkh>
 <727498ba-8ea8-43b9-847b-0280a2bf94e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <727498ba-8ea8-43b9-847b-0280a2bf94e3@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Oct 18, 2023 at 05:40:08PM +0200, Marco Pagani wrote:
> On 2023-10-18 13:50, Greg KH wrote:
> > On Wed, Oct 18, 2023 at 11:39:01AM +0200, Marco Pagani wrote:
> >> On 18/10/23 09:50, Greg KH wrote:
> >>> On Wed, Oct 18, 2023 at 10:02:08AM +0800, Xu Yilun wrote:
> >>>> On Tue, Oct 17, 2023 at 07:17:29PM +0200, Greg KH wrote:
> >>>> NULL ptr is referenced.
> >>>>
> >>>> So do fpga-bridge/region-test.
> >>>>
> >>>> Patch #1 adds a common helper to generate a platform driver.
> >>>
> >>> Don't abuse platform devices/drivers like this, this is not a platform
> >>> device or driver.  If you really want to do this, use a real driver and
> >>> device, not a platform one please.
> >>
> >> Other test suites, like DRM suites, already use fake platform devices and
> >> drivers. Moreover, many real FPGA IPs, like reconfiguration controllers and
> >> bridges, are indeed modeled as platform devices. What is the benefit of
> >> using a real driver and device?
> > 
> > Again, please do not abuse platform devices and drivers when they should
> > not be used.  I can't catch all abuses, but when I do see them, I do
> > object to them.
> 
> Could you please elaborate a little more on why using platform drivers
> and devices for test cases is an abuse so I can improve the test suite?

Because they just are not platform devices.

A platform driver is one that has hardware resources like DT or ACPI or
other real resources that talk to hardware and are not on a discoverable
bus, they are NOT fake devices with no actual hardware resources.

If you need a "fake" device, make a fake device, that's what virtual
devices are for there are other solutions as well depending on how you
want to use it.

thanks,

greg k-h
