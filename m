Return-Path: <linux-fpga+bounces-96-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C84825D14
	for <lists+linux-fpga@lfdr.de>; Sat,  6 Jan 2024 00:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A12628514A
	for <lists+linux-fpga@lfdr.de>; Fri,  5 Jan 2024 23:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5F1364A0;
	Fri,  5 Jan 2024 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZuhBA3D"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF603609F
	for <linux-fpga@vger.kernel.org>; Fri,  5 Jan 2024 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704496539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SR4FNZ1ZczSS8WEbs/1VXeRwzlcPX29OcKlDtIlAL20=;
	b=NZuhBA3Dwmz863o/aVeDvECvZjJVkfTLZ1dF+aGMpatlSTz2aQPCmSSRijzzURBIawg5rN
	WzMob+psjTeO86VKQHLNH+eHx75GQbGzwtDviDNrHmmssXpSMRvrhQsg+iLIjTx973yFo4
	Iore3UqB+/msIQZFTWA9h9x+ofr5GF4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-x7cSLkawPMyUsQ5aTb8z_Q-1; Fri, 05 Jan 2024 18:15:38 -0500
X-MC-Unique: x7cSLkawPMyUsQ5aTb8z_Q-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78158f4ace7so8976285a.0
        for <linux-fpga@vger.kernel.org>; Fri, 05 Jan 2024 15:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704496537; x=1705101337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SR4FNZ1ZczSS8WEbs/1VXeRwzlcPX29OcKlDtIlAL20=;
        b=F/QVNal8UjhdKhKpiA3Yjn02rd7+U78c3n69hIJ02vJcypBrCD/AQSl0iZJkx5C1s5
         RPuMxJpFJ6Gr7XqRb86IqCYX5aGd/PqiC4rxO6/ln4wvaF6oUZSsmPGuABUOWi3oF0Sp
         /gGLb1SSy9qEQSZhnG9am+VvyDA328kdiuK9Q1XjRtAJNsnhM7DRPLHvbCbqHvgXPLXd
         vwkDRYA9hXCitsytnyatdlfuLMiwPR6ZEj4ukxsUHvhALjylBaVJrPi//SOSKJxquprZ
         BdGFVVOxAm8Ha6Rktiat383LqXQW3BC7jIImHF0vQAGKXwu1aMCcIw+q2YbKJWro6Ol3
         YrKA==
X-Gm-Message-State: AOJu0YzoAV0GvI8aoTPj/rjLxIjRGavDpD32tC4Sys5N+BuB23q8+JZd
	B6wqPvayp9PS3sg9KIocUENxUehEQ5BoKJnFTFtlFdjR7zEKTem0t3jsSRd4RLZGvq3ujunXCL8
	0Ll8Xx3rBp4SPzau8JoIOZzVbeKnh
X-Received: by 2002:a05:620a:2016:b0:783:d29:70d6 with SMTP id c22-20020a05620a201600b007830d2970d6mr146624qka.20.1704496537576;
        Fri, 05 Jan 2024 15:15:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGURTTAvcO6Ox2UfaSzbvaF3XPwF+qniPKVpD0F1FEx3oJvjon3DArqvqc0mtpcKJ61admeNg==
X-Received: by 2002:a05:620a:2016:b0:783:d29:70d6 with SMTP id c22-20020a05620a201600b007830d2970d6mr146611qka.20.1704496537331;
        Fri, 05 Jan 2024 15:15:37 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id i9-20020a05620a0a0900b00781bd8b06f8sm935915qka.62.2024.01.05.15.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 15:15:36 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [RFC PATCH v4 0/1] fpga: improve protection against low-level control module unloading
Date: Sat,  6 Jan 2024 00:15:25 +0100
Message-ID: <20240105231526.109247-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC proposes a solution to keep protecting the fpga manager against
the unloading of the low-level control modules while addressing the
limitations of the current implementation. Currently, the code assumes
that the low-level module registers a driver for the parent device that
is later used to take the module's refcount. This proposal removes this
limitation by adding a module owner field to the fpga_manager struct
that can be set while registering the manager.

For more context, please refer to these threads:
https://lore.kernel.org/linux-fpga/ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050
https://lore.kernel.org/linux-fpga/ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050

v4:
- Use helper macros to set the owner module
v3:
- Improved locking
v2:
- Fixed protection against races during module removal

Marco Pagani (1):
  fpga: add an owner and use it to take the low-level module's refcount

 drivers/fpga/fpga-mgr.c       | 93 ++++++++++++++++++++++-------------
 include/linux/fpga/fpga-mgr.h | 80 +++++++++++++++++++++++++++---
 2 files changed, 134 insertions(+), 39 deletions(-)


base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
-- 
2.43.0


