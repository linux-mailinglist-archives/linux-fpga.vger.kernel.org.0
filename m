Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6574EA7AD9
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Sep 2019 07:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfIDFqY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Sep 2019 01:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDFqX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 4 Sep 2019 01:46:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF7523400;
        Wed,  4 Sep 2019 05:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567575983;
        bh=HmYUObPZf4pKykbFgg42DdOktB2DZxiLl08xMY5iFIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zfpb/hX3s3TBvjEXZBVupbuawKvevsuv6Y/5MEt6jrt56ejutiHCAWBkn0dQNTH50
         lNhqz2XR5SHThyCB3tx+Y7QWxyJeFkOnZFcc/y9QWdNPQYxe0Jvt0dxoq/yPlutS7x
         wMlS51J7hwup2e5IFNF60Z87iq5XtKjuMPbrOnzk=
Date:   Wed, 4 Sep 2019 07:46:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     moritzf@google.com, hao.wu@intel.com, linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] FPGA DFL Changes for 5.4 (late, sorry)
Message-ID: <20190904054606.GA4511@kroah.com>
References: <20190904030020.GA5534@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904030020.GA5534@archbox>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 03, 2019 at 08:00:20PM -0700, Moritz Fischer wrote:
> Hi Greg,
> 
> not sure I got this one right. It's a bit complicated, since there's
> some dependencies on stuff already in char-misc-next as well as the
> dev_groups_all_drivers.
> 
> Let me know if I messed up.

All looks good, now merged, thanks.

greg k-h
