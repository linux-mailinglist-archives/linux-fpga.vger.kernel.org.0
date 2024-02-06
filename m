Return-Path: <linux-fpga+bounces-249-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004AE84B2E1
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Feb 2024 11:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AECC1C23175
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Feb 2024 10:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEFC7CF18;
	Tue,  6 Feb 2024 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVjKdDIs"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C673D54A
	for <linux-fpga@vger.kernel.org>; Tue,  6 Feb 2024 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217015; cv=none; b=RAkGWqiAftWyQf1WvFt54kfejvHb8j1JBVVppr6e5jBUU1cnJPJWNIpaXx/cGG5Tsftm/u4I+VqSs5Hh7xXqEbsSWpefA7MihuHoEKmbNUzcPvRg/zOyKX/SJqVHoAjcO19zX1rZGr7RHrJdzxRehzi3hE2Eu6hLvb07N4bIOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217015; c=relaxed/simple;
	bh=8vOg9PtERGFIzxGfr1uQ777xA4qgfnvqvPqJZtaB7dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmdZhzsLjvKgMzOoLEV0H81XgMFK7pygtyGuaVPrWCPeRa7lsKHDYQlj+8uogkZXBxHy3fnGukExgii1MdjeSu3yiJX2U2XHkoyZtFVPSshbgcW5mNLvGJ88oBcQxRlJJ2RszcAlbKCCduXToxShNFabQcQZMioTwoY2C8l9E4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RVjKdDIs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707217012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NOcDAAfRrdOruM3vQufk8xXSJsuXJBYipbiUl5Fyob4=;
	b=RVjKdDIsSP0Q7OmBmNbtiO0JJ/ddL7gbF4tIuUVu58JvPlUy0SMNco+Y0PpWXFts19m9Jm
	uV8E3oMqcWf5HKL0kqmnHwx+JCcpFgOC7Bvjn7EdKw4HGsBsQak7ek6dCCs/CbYhBrNUYk
	SCVbIpIausJ+ok7Lk2phoncseslXF44=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-Gu1SmNyEPqyqA8r52Voiig-1; Tue, 06 Feb 2024 05:56:51 -0500
X-MC-Unique: Gu1SmNyEPqyqA8r52Voiig-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68c4f2aca5dso95047316d6.3
        for <linux-fpga@vger.kernel.org>; Tue, 06 Feb 2024 02:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707217011; x=1707821811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOcDAAfRrdOruM3vQufk8xXSJsuXJBYipbiUl5Fyob4=;
        b=Hcgh7s4WusNVB7xj3tKhRkkdxbAedxqm3GqM1PzNtG9QPi5PT0dhAwKlkYensnsVLQ
         X66hf3Dx+OTn0QwHuL3ryMaJopzG6PDglHepP1ECod/tU8xNILwL2X0Mn8ewl6k4y3ZM
         gASO1RQ1DRm61R6xnIDXYpUmHluoN+bqCMkueo7t6vmQN+InWsGEqTugeN0rPLKrmPvg
         lSrde5MB7+8veewvpXs0G9SjrUJ+O9t+8s2ThkGd/wZ3BNxcCijXTGtnDRB13/eUzhJD
         q3LXC94E01OBDwOLTv+5l/QJxtsL9Dsc8qiCiDw3Hrk+yV+3tuE/1FZOjHb2nNCpC0Va
         zatQ==
X-Gm-Message-State: AOJu0YyxgLH6HjuX6ieFVBhTpLzNx/gLVy6sYrYQC8A1nKBkM7r4czn2
	TKCbAmK+UCahWu2IoaqkYJyA+gqo0fIFbDZGmbARG+gcibDD8gxpPeAzH3j4Phz1itgzPuq6Wvq
	Im7lgtWkwkSh5L+XUvPEtxEeX2orrruojbDXIJxC0Hoh902AVP1J03FQ6rg==
X-Received: by 2002:a05:6214:21e9:b0:680:f8d2:c828 with SMTP id p9-20020a05621421e900b00680f8d2c828mr2323849qvj.16.1707217010848;
        Tue, 06 Feb 2024 02:56:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhff2DlHZd/ZEK5FY5fiFC/T9Pyc4sJSO0MZ/TglPCHuCL3o0cMWVg9QtToY7v6Z+KW8fOWg==
X-Received: by 2002:a05:6214:21e9:b0:680:f8d2:c828 with SMTP id p9-20020a05621421e900b00680f8d2c828mr2323839qvj.16.1707217010625;
        Tue, 06 Feb 2024 02:56:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUy6sn6pHYdmwklCBeIPLcmA1sdU6HtNEqv2vI89wRaRuOTRoeDVvkMZSTi8k4LvKuQ+uw3wya3VWjclc935+MWSLQ1FLMXeUPsNKCqJwqo0N6g9CaWIXEbpHIvFW4hY7hdrx/83/UaLEwREYUxlSfIj5OurBwqw55BcvAuQ+neLuoy4C+Z+fIT9uVzHZvhMc9Sz4UEcu6C+LqYKemieSEGBzAP8IaKN126K1tr1tdC4NdMTGdm8oh6aM6Phr+EB36wRQfo/rv0tJjtyfcAZEnIX73Z08xwdYPfFImmhKT+pjVQWpQmPMlEnwVxqnnVrD4ZhbO4AMKT0PFYi1Oki6vJ+bbj
Received: from klayman.redhat.com (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id hf15-20020a0562140e8f00b0068c95b634d3sm909547qvb.11.2024.02.06.02.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:56:50 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [RFC PATCH 0/1] fpga: bridge improve protection against low-level control module unloading
Date: Tue,  6 Feb 2024 11:56:43 +0100
Message-ID: <20240206105644.41185-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC proposes a solution to keep protecting the fpga bridge against
the unloading of the low-level control modules while addressing the
limitations of the current implementation. Currently, the code assumes
that the low-level module registers a driver for the parent device that
is later used to take the module's refcount. This proposal removes this
limitation by adding a module owner field to the fpga_bridge struct that
can be set while registering the bridge.

The RFC patch is based on top of ("fpga: remove redundant checks for
bridge ops").

https://lore.kernel.org/linux-fpga/20240201155713.82898-1-marpagan@redhat.com/

Marco Pagani (1):
  fpga: bridge: improve protection against low-level control module
    unloading

 Documentation/driver-api/fpga/fpga-bridge.rst |  7 ++-
 drivers/fpga/fpga-bridge.c                    | 61 +++++++++++--------
 include/linux/fpga/fpga-bridge.h              | 10 ++-
 3 files changed, 47 insertions(+), 31 deletions(-)

-- 
2.43.0


