Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E00B952DD
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Aug 2019 02:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfHTAzD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Aug 2019 20:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbfHTAzD (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 19 Aug 2019 20:55:03 -0400
Received: from localhost (unknown [76.14.1.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1542622CE8;
        Tue, 20 Aug 2019 00:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566262502;
        bh=54/BT8SZJgAIMpAnqLxKslYwihrI9EqMeG7ckMwwug4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCajfvk6Dgv1W/dYd8Mxl+bCF5t07OaW61VP0BSgavB1mogw7ClwmszHPGLUphxcF
         rdqYfXRDwSRFQkNUNMYMgBuIMlb7eyjfudsVpBipU0uBwlZie+VikZNEVpO3Kd0Rnz
         gTOJFHCus0SeCnhvfVrOuv89wIpTL36sNFZpN0LY=
Date:   Mon, 19 Aug 2019 22:51:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org
Subject: Re: [PATCH v5 0/9] FPGA DFL updates
Message-ID: <20190819205124.GA28978@kroah.com>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
 <20190819053133.GA31244@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819053133.GA31244@hao-dev>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 19, 2019 at 01:31:33PM +0800, Wu Hao wrote:
> On Mon, Aug 12, 2019 at 10:49:55AM +0800, Wu Hao wrote:
> > Hi Greg,
> > 
> > This is v5 patchset which adds more features to FPGA DFL. Marjor changes
> > against v4 are sysfs related code rework to address comments on v4.
> > 
> > Please help to take a look. Thanks!
> 
> Hi Greg,
> 
> Did you get a chance to take a look at this new version patchset? :)

I'm not the FPGA maintainer, what about the review from the other one
first?  :)

thanks,

greg k-h
