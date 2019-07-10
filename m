Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64835640CF
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Jul 2019 07:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbfGJFyU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Jul 2019 01:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfGJFyU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 10 Jul 2019 01:54:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8498B20838;
        Wed, 10 Jul 2019 05:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562738060;
        bh=Ljmkhznzerdq6lPRmNr087kgdnCLj9XSJ2ycEHrizro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8RbnzC0QTCX1b0xyF+5bia3Pnn890GSi36zzMOkPm0iBluo0DWJKZ6cqfS7OiAPl
         LTECJSosy5xaWsRZ68qC1GpkM6pI17bAK/8v19fuBk/tIAhBQSOy6ljC6+Dt1a8EuZ
         77ipsiE7CKvjuZnp2nY/riuOCm4VZndcJsTDJhxc=
Date:   Wed, 10 Jul 2019 07:54:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org
Subject: Re: [PATCH v2 00/11] FPGA DFL updates
Message-ID: <20190710055417.GA5778@kroah.com>
References: <1562286238-11413-1-git-send-email-hao.wu@intel.com>
 <20190710050746.GA28620@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710050746.GA28620@hao-dev>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jul 10, 2019 at 01:07:46PM +0800, Wu Hao wrote:
> On Fri, Jul 05, 2019 at 08:23:47AM +0800, Wu Hao wrote:
> > Hi Greg / Moritz
> > 
> > This is v2 patchset which adds more features to FPGA DFL. This patchset
> > is made on top of patch[1] and char-misc-next tree. Documentation patch
> > for DFL is dropped from this patchset, and will resubmit it later to
> > avoid conflict.
> 
> Hi Greg,
> 
> Did you get a chance to take a look at this new version to see if these
> patches are good to take?
> 
> Hope we can catch up with the merge window.

You sent them last Friday.  I actually tried to not do kernel work last
weekend.  The merge window opened up on Sunday.  My trees should have
been closed last week, so no, this missed this merge window, I'll
review these patches once 5.3-rc1 is out.

thanks

greg k-h
