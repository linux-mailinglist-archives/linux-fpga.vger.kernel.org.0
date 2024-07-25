Return-Path: <linux-fpga+bounces-574-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F0093C263
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Jul 2024 14:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56701F21D80
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Jul 2024 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F0F19AA59;
	Thu, 25 Jul 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cd5z6w/2"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB513C907
	for <linux-fpga@vger.kernel.org>; Thu, 25 Jul 2024 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911842; cv=none; b=Mnjyb+31dMg1zUDa/tUavz0Azb+H5TxmCzhO5//qRYi8hIssZX8K6jxlBwxmFJ7/eQROO/3n5PAIdTndu+dvhG90kvrOiLk3w1hj5izYd+QZeg5z3eq0GPxBMYCisZ7NUR+8QpNZc1CZW62K9mYxnqxqhi4+oINcyFs6Jyf0Xy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911842; c=relaxed/simple;
	bh=u/n8FIBqeUNFl3zfbTvcsodu4bW5c400cD9afKq/9uA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnjrH1SyZIGdUYSXS3nWZya11Y4tzUhSh2DW2qqYriphNe0F9a4YBJI3+SrsKWZLKFcusxn9GmI4+wfb9HYaUM6mtSYkQQ8TwsP3I6QzIEx+vAV8w5kEijGFDSE/1CP/5sXsQkyOImnEcrCiufEdiyZPwueoRx4Pe3raTEjAvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cd5z6w/2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721911839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aiC+tGdGBJ14JK0EM+dRzM1914+RfFNFtqMWibxNajs=;
	b=Cd5z6w/2aesYuR4WUSk5d7F5Aan1QEjh59wEYBtLc7HyFj/zkjOW8oxbGdUtbYgH6Tkpgs
	WFgq84EbamY2Vo/XxBTbwfSrW4FFa5pkE6LsqCky9cbBd1kiq5kgaMnsy0bjKrPMj0rga8
	ErUzmtXy6MX0wxFhAekWIFT7siAg4bo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-TlRM2PUeNuiFer45XNQqhg-1; Thu, 25 Jul 2024 08:50:38 -0400
X-MC-Unique: TlRM2PUeNuiFer45XNQqhg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-369bf135b49so493108f8f.0
        for <linux-fpga@vger.kernel.org>; Thu, 25 Jul 2024 05:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721911837; x=1722516637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiC+tGdGBJ14JK0EM+dRzM1914+RfFNFtqMWibxNajs=;
        b=uPdkJiZ2G+Mnz4RRhqQ46SEGBbZaRflwjlxIZExrAHQJ23GCgn9EPEnCDk+EL1zyIo
         BtSItRvwNz/SDAdWmFyX/szhANoCvx3zfAI6m1upK1SCl0XucFFksG/st/Ob9LHuZCFn
         +nISguKJil4WvnJSTlDPgtE0xQOY0Mxej7Y8eJTkzjVzlb3/W0EeuUKhekf+c/PGs0aK
         G5BOY9egYoGL9Rjf0MT2z63ZIXq4PEyTxba1BcxQ0h03p8E0CI+JCUZMWhElCSdmyk4m
         VqfNLONNxLVxaPmXwf8BQ7m0X2i08fXzoNQaU48SbuCfAfA6tBF9yBL9oVOrBD03f4YR
         Bdgw==
X-Forwarded-Encrypted: i=1; AJvYcCUGCPDMb/Wy3NB+4BemG9nLKRkV7a86lWTAY7dYMbe3mMlHI2zTRnNmnVf3iGOk+DEtK6c608b8ULlZ1tiKzEdwKYfcUq9BWSii+g==
X-Gm-Message-State: AOJu0YxiWJEKpk0nHTsxGI4Xzuy7mQ9r+2QikEuf7OLXfEhZkdmCra4m
	2Eqla0qXWgZsjG0E798jeKacXBPAnrVCIpqdShsIgFG8JR65NykeQ+AFFADMkLZyd1YV8U755Ge
	RBue1nm9Vjuj+ym5L89PpYkmRW6OLUePemrWlMv94JcXYegf1ABfFfyMNRA==
X-Received: by 2002:a5d:6847:0:b0:360:866f:5083 with SMTP id ffacd0b85a97d-36b31baa861mr1863123f8f.32.1721911837190;
        Thu, 25 Jul 2024 05:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvNOfiyZLdndMxewqoDL+v5f5t2gA5QKku5uTpws/6FD57ncMwj1yC6F4sK8Meatae3pXBHQ==
X-Received: by 2002:a5d:6847:0:b0:360:866f:5083 with SMTP id ffacd0b85a97d-36b31baa861mr1863099f8f.32.1721911836736;
        Thu, 25 Jul 2024 05:50:36 -0700 (PDT)
Received: from klayman.redhat.com (host-82-62-247-97.business.telecomitalia.it. [82.62.247.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9393sm2092301f8f.26.2024.07.25.05.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:50:36 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [PATCH 0/3] Simplify and improve fpga test suites using deferred actions
Date: Thu, 25 Jul 2024 14:50:28 +0200
Message-ID: <20240725125031.308195-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use deferred actions to simplify fpga test suites and avoid potential
memory leaks when test cases fail. Deferred actions are executed when a
test is completed either successfully or unsuccessfully (e.g., due to a
failed assertion).

Marco Pagani (3):
  Simplify and improve the fpga manager test suite using deferred
    actions
  Simplify and improve the fpga bridge test suite using deferred actions
  Simplify and improve the fpga region test suite using deferred actions

 drivers/fpga/tests/fpga-bridge-test.c | 25 +++++++---------
 drivers/fpga/tests/fpga-mgr-test.c    | 28 +++++++++++-------
 drivers/fpga/tests/fpga-region-test.c | 41 ++++++++++++++++-----------
 3 files changed, 52 insertions(+), 42 deletions(-)


base-commit: 3a0fa8e97d3024de199634667900b6a90bbe43d0
-- 
2.45.2


