Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811F341B2F1
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Sep 2021 17:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbhI1PaV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 28 Sep 2021 11:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241443AbhI1PaV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 28 Sep 2021 11:30:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98E70611BD;
        Tue, 28 Sep 2021 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632842922;
        bh=+o8hVDxsN//sxI+EeD8Nwo2KD1V2EcteaPJ+I0QSrX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xMi/htozk/fMwOS3UqyiX2oCZ5w+THudj4ZBjlqWXaWnK3JAk436iloGTn5FF1q07
         Dme4iixvpfvqj+H4fWxI7z2StcMDpsaTKTfdotPM0/sMzzMPzl6ZFJP4FQZM1WV5lS
         6Ua5/fIVdQevogxi+LgglOqRK9r/r7fb7ncR7JSk=
Date:   Tue, 28 Sep 2021 17:28:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Add Hao and Yilun as maintainers
Message-ID: <YVM0p3xrck0zriHd@kroah.com>
References: <20210928150227.22275-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928150227.22275-1-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 28, 2021 at 08:02:25AM -0700, Moritz Fischer wrote:
> Hao and Yilun have agreed to help out with maintenance.
> Both have been active in the Linux FPGA community for a long time
> and we need backups for vacation and load-balancing.
> 
> Cc: Xu Yilun <yilun.xu@intel.com>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I need an ack from the two new people here in order to take this :)

thanks,

greg k-h
