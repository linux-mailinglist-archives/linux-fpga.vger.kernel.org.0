Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95454893F0
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jan 2022 09:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242132AbiAJIpu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jan 2022 03:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242077AbiAJIoh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jan 2022 03:44:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B80CC06173F;
        Mon, 10 Jan 2022 00:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=aAoxNTNqcx1/Wp25mXU6aNi2Iy
        2lgu7s7h7HAfHR6qmIdGx3ErqIPdTOu54PRsFoiUSxkQ1+PTzkv49LhVRhGukmeEewaPlCnTRzrKp
        TYOM7yrpL1zNT3y0VZDoWo8aUKSOVBID61d5b6kWRN5Dy5DQb72SY19lCLXslR5DzznVg6e3CeoxD
        /Xp2tZHdkLRL8vyfEbgwNN27w0hr+aZUc/9ZggkuBbW16jwWmxckGNGDD1MfJNrSEMAnrcR25uQ26
        K6frammTY8v38SGQ4heAHz9PtHXBOHLwkBT4/DWDVDG+uOiBWvR4oIG9RrwQFfwb41GhMd56+ixLy
        +X0Dbhqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qI1-009zeO-RB; Mon, 10 Jan 2022 08:44:29 +0000
Date:   Mon, 10 Jan 2022 00:44:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 03/16] fpga: dfl: pci: Remove usage of the deprecated
 "pci-dma-compat.h" API
Message-ID: <Ydvx7W4ab5O+vuQF@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <4a0a48fb682d13e6861f604d3cad3424672bee1f.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a0a48fb682d13e6861f604d3cad3424672bee1f.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
