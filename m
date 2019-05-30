Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE692FE89
	for <lists+linux-fpga@lfdr.de>; Thu, 30 May 2019 16:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfE3OxE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 30 May 2019 10:53:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfE3OxE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 30 May 2019 10:53:04 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F55925BBD;
        Thu, 30 May 2019 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559227983;
        bh=hSvO5ISBULPkbviI2yZeC2rbY+FDFr8e4DfuyNFkTtA=;
        h=From:To:Cc:Subject:Date:From;
        b=Ox5gXAdgNOsgRenvTeoe2DHlne5jvjXccLrHeEP9KkZCXWN7LJuUIoQZ2PPRN1bYK
         ASEZXvZiogKCADZzJYDvuDeFzrYCq3ni7DB3NieE0ohRx3tC0lSF5ouEYwLbxD1f3Q
         9gkqtONkADgT8csI3v/b1i18e2l9WOuzNE6ivXhk=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 0/1] one fix for FPGA
Date:   Thu, 30 May 2019 09:52:58 -0500
Message-Id: <20190530145259.4189-1-atull@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

Please take this FPGA fix.  It have been reviewed on
the mailing list and applies cleanly on current
linux-next and char-misc-testing.

Thanks,
Alan

Moritz Fischer (1):
  fpga: zynqmp-fpga: Correctly handle error pointer

 drivers/fpga/zynqmp-fpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.21.0

