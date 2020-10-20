Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BBA2935C4
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Oct 2020 09:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbgJTHcR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Oct 2020 03:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731280AbgJTHcR (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Oct 2020 03:32:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 466AC2237B;
        Tue, 20 Oct 2020 07:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603179136;
        bh=lmarhGMgRtdYpO9BC/zBLgxGRIySPhWIx01jkmu4QJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOfmn2Q2kde8SFe2HnKK/9/x0BapwMkE2toRRfFKjrapfOViEZHS+Qh+Qc2ywk/SW
         1zLi+zDEtO17Dqhi5G502FMkvKMIm0FsdPIRnWv8igFSdTyGjZCCPncwMQTRWRW5p2
         9h8Z+shoYxJcwQTtx9TTLGQo5oSmyZ/SDXhw5r8w=
Date:   Tue, 20 Oct 2020 09:32:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH 1/2] fpga: dfl: add driver_override support
Message-ID: <20201020073259.GA3803984@kroah.com>
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
 <63d7730b-d9b8-c75d-16f6-3ebb507aabaa@redhat.com>
 <20201019040612.GA16172@yilunxu-OptiPlex-7050>
 <f767b9a0-1db8-7ced-6bd9-5ee1f58d40da@redhat.com>
 <20201020071158.GC28746@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020071158.GC28746@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 20, 2020 at 03:11:58PM +0800, Xu Yilun wrote:
> I think it is normal case that a driver is successfully registered but
> doesn't match any device because it provides no id_table.

How is that "normal"?  What would ever cause that driver to be bound to
a device then?

And you better not say userspace is responsible for it...

thanks,

greg k-h
