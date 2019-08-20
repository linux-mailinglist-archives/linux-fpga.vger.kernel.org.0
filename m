Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3CD9552B
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Aug 2019 05:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfHTDbk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Aug 2019 23:31:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:4877 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728898AbfHTDbk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 19 Aug 2019 23:31:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 20:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,407,1559545200"; 
   d="scan'208";a="183060736"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga006.jf.intel.com with ESMTP; 19 Aug 2019 20:31:37 -0700
Date:   Tue, 20 Aug 2019 11:14:19 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>, mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        atull@kernel.org
Subject: Re: [PATCH v5 0/9] FPGA DFL updates
Message-ID: <20190820031419.GA25968@hao-dev>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
 <20190819053133.GA31244@hao-dev>
 <20190819205124.GA28978@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819205124.GA28978@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 19, 2019 at 10:51:24PM +0200, Greg KH wrote:
> On Mon, Aug 19, 2019 at 01:31:33PM +0800, Wu Hao wrote:
> > On Mon, Aug 12, 2019 at 10:49:55AM +0800, Wu Hao wrote:
> > > Hi Greg,
> > > 
> > > This is v5 patchset which adds more features to FPGA DFL. Marjor changes
> > > against v4 are sysfs related code rework to address comments on v4.
> > > 
> > > Please help to take a look. Thanks!
> > 
> > Hi Greg,
> > 
> > Did you get a chance to take a look at this new version patchset? :)
> 
> I'm not the FPGA maintainer, what about the review from the other one
> first?  :)


Sure! :)


Hi Moritz

Could you please help review these patches? Thanks! :)

Thanks
Hao

> 
> thanks,
> 
> greg k-h
